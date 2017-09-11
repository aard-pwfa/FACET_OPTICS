function [ws,A_0,nu,kGamma] = ionRatePPT(Ui,I,lambda,nK)
% Function for calculating ionization rate using PPT theory
% For now, only consider l=m=0 and Z=1
% Ui     = ionization energy in eV
% I      = intensity in W/cm^2
% lambda = wavelength in nm
% w      = ionization rate in s^-1
% e.g ionRateAU(13.6,1E14,800) for hydrogen with Ti:Saph

% First, load atomic units and convert quanitites
AU_consts;
E_GV = EfromI(I);
IonEng_au = Ui/AU_Eh;
Efield_au = E_GV/AU_F;
lambda_au = lambda/AU_a0;
omega_au  = 2*pi*AU_c/lambda_au;
F0 = (2*IonEng_au)^(3/2);

% From here on out, all calculations are unitless
kGamma   = keldyshAU(IonEng_au,Efield_au,omega_au);
%disp(kGamma);
nStar    = nModified(IonEng_au);
%disp(nStar);
lStar    = lModified(nStar);
%disp(lStar);
cStar2   = ClebschGordonSquared(nStar,lStar);
%disp(cStar2);
[A_0,nu] = AmFunction(omega_au,kGamma,IonEng_au,nK);
%disp(A_0);
gGamma   = gammaG(kGamma);

% Now compute normalized ionization rate
w = cStar2 * sqrt(6/pi) * IonEng_au * (2*F0/Efield_au)^(2*nStar - 3/2) * ...
    (1+kGamma^2)^(3/4) * A_0 * exp(-(2/3)*(F0/Efield_au)*gGamma);

% Finally, multiply the atomic frequency to convert to s^-1
%disp(AU_omega);
%disp(w);
ws = AU_omega * w;
%ws =  w;

% Modified Energy Level
function nStar  = nModified(IonEng_au)

nStar = 1/sqrt(2*IonEng_au);

% Modified OAM Level
function lStar  = lModified(nStar)

lStar = nStar - 1;

% Modified Clebsch-Gordon
function cStar2  = ClebschGordonSquared(nStar,lStar)

cStar2 = 2^(2*nStar)/(nStar*gamma(nStar+lStar+1)*gamma(nStar-lStar));

% Alpha function
function aGamma = alphaG(kGamma)

aGamma = 2*(asinh(kGamma) - kGamma/sqrt(1+kGamma^2));

% Beta function
function bGamma = betaG(kGamma)

bGamma = 2*kGamma/sqrt(1+kGamma^2);

% Gamma function
function gGamma = gammaG(kGamma)

gGamma = (3/(2*kGamma))*((1+1/(2*kGamma^2))*asinh(kGamma) - sqrt(1+kGamma^2)/(2*kGamma));

% Nu function
function nu = NuFunction(IonEng_au,kGamma,omega_au)

nu = (IonEng_au/omega_au)*(1+1/(2*kGamma^2));

% W_m function (m = 0)
function w_0 = WmFunction(x)

w_0 = exp(-x^2) * integral(@(y) exp(y.^2),0,x);

% A_m function (m = 0)
function [A_0,nu] = AmFunction(omega_au,kGamma,IonEng_au,nK)

A_base = 4/sqrt(3*pi) * kGamma^2/(1+kGamma^2);

nu = NuFunction(IonEng_au,kGamma,omega_au);
k_min = floor(nu)+1;
k_max = k_min + nK;
K_good = k_min:k_max;


K_sum = 0;
for k = 1:numel(K_good)
    K_sum = K_sum + exp(-alphaG(kGamma)*(K_good(k)-nu))*WmFunction(sqrt(betaG(kGamma)*(K_good(k)-nu)));
end

A_0 = A_base * K_sum;

