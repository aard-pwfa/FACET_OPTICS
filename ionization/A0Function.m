function [A_0,nu,ks,k] = A0Function(omega_au,kGamma,IonEng_au,lowLimit)

% Maximum number of k
nK = 1000;

% Amplitude prefactor
A_base = 4/sqrt(3*pi) * kGamma^2/(1+kGamma^2);

% Minimum number of photons
nu = NuFunction(IonEng_au,kGamma,omega_au);

% Smallest integer number of photons above nu
k_min = floor(nu)+1;

% Range of photons to loop over
k_max = k_min + nK;
K_good = k_min:k_max;
ks = zeros(nK+1,1);

% Loop over photons but stop when terms become small
K_sum = 0;
for k = 1:numel(K_good)
    ks(k) = exp(-alphaG(kGamma)*(K_good(k)-nu))*WmFunction(sqrt(betaG(kGamma)*(K_good(k)-nu)));
    if  ks(k) < lowLimit
        K_sum = K_sum + ks(k);
        break;
    else
        K_sum = K_sum + ks(k);
    end
end

A_0 = A_base * K_sum;