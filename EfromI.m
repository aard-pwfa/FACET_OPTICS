%% get field strength for given laser intensity
% inputs: Ilaser = laser intensity in W/cm^2
function [ Efield ] = EfromI( Ilaser )

eps0 = 8.854E-12; % F/m
c = 3E8; % m/s
Efield = sqrt((2*Ilaser*1E-14)/(eps0*c)); % GV/m
Efield=double(Efield);

end

