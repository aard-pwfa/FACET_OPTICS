%% get field strength for given laser intensity
% inputs: Ilaser = laser intensity in W/cm^2
function Efield = EfromI( Ilaser )

SI_consts;
Efield = sqrt((2*Ilaser*1E-14)/(SI_eps0*SI_c)); % GV/m
Efield=double(Efield);

end

