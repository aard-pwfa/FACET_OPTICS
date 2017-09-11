function [wPPT,wADK,kGamma,nu,ks,k,aLim] = ionRateALL(Ui,I,lambda,aDelta)
%
% Function for calculating ionization rate using PPT theory
% For now, only consider l=m=0 and Z=1
% Ui     = ionization energy in eV
% I      = intensity in W/cm^2
% lambda = wavelength in nm
% aDelta = Limit on change in A0 function
%
% w      = ionization rate in s^-1
% e.g ionRateAU(13.6,1E14,800,1e-4) for hydrogen with Ti:Saph

% First, load atomic units and convert quanitites
AU_consts;
E_GV = EfromI(I);
IonEng_au = Ui/AU_Eh;
Efield_au = E_GV/AU_F;
lambda_au = lambda/AU_a0;
omega_au  = 2*pi*AU_c/lambda_au;
F0 = atomField(IonEng_au);

% From here on out, all calculations are unitless
kGamma   = keldyshAU(IonEng_au,Efield_au,omega_au);
nStar    = nModified(IonEng_au);
lStar    = lModified(nStar);
cStar2   = ClebschGordonSquared(nStar,lStar);
gGamma   = gammaG(kGamma);

% compute the portion of the rate that just depends on ionization energy
state_factor = cStar2 * sqrt(6/pi) * IonEng_au;

% compute the portion of the rate that depends on field amplitude
amp_factor = (2*F0/Efield_au)^(2*nStar - 3/2) * (1+kGamma^2)^(3/4) * exp(-(2/3)*(F0/Efield_au)*gGamma);

% use the amplitude to set a limit on the terms of the A-function
aLim = aDelta * state_factor * amp_factor;

% compute the A-function so that is automatically calculates how many terms to use
[A_0,nu,ks,k] = A0Function(omega_au,kGamma,IonEng_au,aLim);

% Now compute normalized ionization rate
wPPT = AU_omega * state_factor * amp_factor * A_0;

% Also compute ADK rate
wADK = AU_omega * cStar2 * sqrt(6/pi) * IonEng_au * (2*F0/Efield_au)^(2*nStar - 3/2) * exp(-(2/3)*(F0/Efield_au));
