% SI constants
 SI_c    = 299792458;       % speed of light  [m/s] 
 SI_e    = 1.60217733e-19;  % electron charge [C]
 SI_em   = 9.1093897e-31;   % electron mass [kg]
 SI_eM   = 0.510998928;     % electron mass [MeV/c^2]
 SI_pM   = 938.271996;      % proton mass [MeV/c^2]
 SI_re   = 2.81794092e-15;  % classical radius of electron [m]
 SI_eps0 = 8.854187817e-12; % permittivity of free space [F/m]
 SI_mu0  = 4e-7*pi;         % permeability of free space [T*m/A]
 SI_Z0   = SI_mu0*SI_c;     % free space impedance [ohms]
 
 SI_sband  = 2856e6;          % SLAC s-band freq [Hz]
 SI_sdegs  = 1/(360*SI_sband);  % SLAC s-band deg [s]
 SI_sdegm  = SI_c*SI_sdegs;     % SLAC s-band deg [m]
 SI_sband_k= 2*pi*SI_sband/SI_c; % SLAC cavity s-band wavenumber [1/m]
 
 SI_xband  = 4*SI_sband;        % SLAC x-band freq [Hz]
 SI_xdegs  = SI_sdegs/4;        % SLAC x-band deg [s]
 SI_xdegm  = SI_sdegm/4;        % SLAC x-band deg [s]
 SI_xband_k= 2*pi*SI_xband/SI_c; % SLAC cavity s-band wavenumber [1/m]
 
 SI_hbar   = 1.0545718e-34; % Reduced Planck's Constant [J s]
 SI_h      = 6.626069934e-34; %  Planck's Constant [J s]
 SI_hbar_eV= 6.582119514e-16; % Reduced Planck's Constant [eV s]
 SI_h_eV   = 4.135667662e-15; %  Planck's Constant [eV s]
 
 SI_hartree= 27.211385; % One Hartree = 2 times hydrogen ground state energy
