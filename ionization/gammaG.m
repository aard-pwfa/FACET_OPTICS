function gGamma = gammaG(kGamma)
% Gamma function

gGamma = (3./(2*kGamma)).*((1+1./(2*kGamma.^2)).*asinh(kGamma) - sqrt(1+kGamma.^2)./(2*kGamma));
