function keldysh = get_keldysh(input,E_field)

SI_consts;
I_0 = input.E_ion;
k0 = 2*pi/(input.lambda*1e-6);
omega = SI_c*k0;

keldysh = omega*(2*SI_em*I_0*SI_e)^(1/2)/(2*SI_e*E_field*1e9);