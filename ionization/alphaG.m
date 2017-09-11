function aGamma = alphaG(kGamma)
% Alpha function

aGamma = 2*(asinh(kGamma) - kGamma/sqrt(1+kGamma^2));
