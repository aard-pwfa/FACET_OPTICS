function cStar2  = ClebschGordonSquared(nStar,lStar)
% Modified Clebsch-Gordon

cStar2 = 2^(2*nStar)/(nStar*gamma(nStar+lStar+1)*gamma(nStar-lStar));
