function Ilaser = IfromE( Efield )

SI_consts;
Ilaser = 1e14*SI_eps0*SI_c*Efield^2/2; %W/cm^2
