function ion_cont = ADK_ion(input,output)

tau = 1e15*input.t0;
int = output.Int_line;
E   = EfromI(int);

ion_cont = ADKfrac( input.Z_ion, input.E_ion, E, tau);
ion_cont(ion_cont>1)=1;