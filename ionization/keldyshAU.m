function kGamma = keldyshAU(IonEng_au,Efield_au,omega_au)

kGamma = omega_au*sqrt(2*IonEng_au)./Efield_au;