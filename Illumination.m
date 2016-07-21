function AMP = Illumination(rr,phi,input)

if strcmp(input.illum,'tophat')
    sigma = input.sigma;
    order = 30;
    AMP = sqrt(exp(-(rr.^order)/(2*(sigma)^order)));
elseif strcmp(input.illum,'gaussian')
    sigma = input.sigma;
    order = 2;
    AMP = sqrt(exp(-(rr.^order)/(2*(sigma)^order)));
elseif strcmp(input.illum,'mask')
    sigma = input.sigma;
    AMP = zeros(size(rr));
    AMP(abs(rr)<sigma) = 1;
elseif strcmp(input.illum,'flat')
    AMP = ones(size(rr));
elseif strcmp(input.illum,'gmask')
    sigma = input.sigma;
    order = input.order;
    aptur = input.aptur;
    AMP = zeros(size(rr));
    AMP(abs(rr)<aptur) = sqrt(exp(-(rr(abs(rr)<aptur).^order)/(2*(sigma)^order)));
else
    disp('Bad illumination type');
end