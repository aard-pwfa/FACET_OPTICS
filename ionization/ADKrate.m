function wADK = ADKrate(Ui,I)

% Function for calculating ionization rate using PPT theory
% For now, only consider l=m=0 and Z=1
% Ui     = ionization energy in eV
% I      = intensity in W/cm^2
% wADK   = ionization rate in s^-1
% e.g ADKrate(13.6,1E14) for hydrogen

% First, load atomic units and convert quanitites
AU_consts;
E_GV = EfromI(I);
IonEng_au = Ui/AU_Eh;
Efield_au = E_GV/AU_F;

nStar    = nModified(IonEng_au);
lStar    = lModified(nStar);
cStar2   = ClebschGordonSquared(nStar,lStar);
F0       = (2*IonEng_au)^(3/2);

w = cStar2 * sqrt(6/pi) * IonEng_au * (2*F0/Efield_au)^(2*nStar-3/2)*exp(-(2/3)*(F0/Efield_au));
wADK = AU_omega * w;

% Modified Energy Level
function nStar  = nModified(IonEng_au)

nStar = 1/sqrt(2*IonEng_au);

% Modified OAM Level
function lStar  = lModified(nStar)

lStar = nStar - 1;

% Modified Clebsch-Gordon
function cStar2  = ClebschGordonSquared(nStar,lStar)

cStar2 = 2^(2*nStar)/(nStar*gamma(nStar+lStar+1)*gamma(nStar-lStar));
