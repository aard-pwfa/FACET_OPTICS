function nu = NuFunction(IonEng_au,kGamma,omega_au)
% Number of photons function

nu = (IonEng_au/omega_au).*(1+1./(2*kGamma.^2));