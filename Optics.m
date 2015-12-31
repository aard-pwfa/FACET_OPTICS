function PSI = Optics(rr,phi,input,PSI)

if nargin < 4
    PSI = zeros(size(rr));
end

% Optic parameters
if strcmp(input.type,'axilens')
    k0  = 2*pi/input.lambda;
    R   = input.R;
    f0  = input.f0;
    Dz  = input.Dz;
    PSI = k0*R^2/(2*Dz)*log(f0+Dz/(R^2)*rr.^2);
elseif strcmp(input.type,'axicon')
    gamma = 0.46*input.ax_ang*pi/180;
    kp    = 2*pi*sin(gamma)/input.lambda;
    PSI   = kp*rr;
elseif strcmp(input.type,'kinoform')
    gamma = input.gamma;
    kp    = 2*pi*sin(gamma)/input.lambda;
    m     = input.m;
    PSI   = kp*rr+m*phi;
elseif strcmp(input.type,'lens')
    k0  = 2*pi/input.lambda;
    f   = input.f;
    PSI = k0*rr.^2/(2*f);
elseif strcmp(input.type,'axiramp')
    k0  = 2*pi/input.lambda;
    R   = input.R; 
    f0  = input.f0;
    Dz  = input.Dz;
    PSI = k0*(rr*R/Dz-f0*R^2/Dz^2*log(1+Dz*rr/(R*f0)));
else
    disp('Bad optic type');
end