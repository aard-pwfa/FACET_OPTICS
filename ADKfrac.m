%% fraction of ionized atoms from ADK method
% input:
%       Z    = atomic residue
%       xi   = ionization energy in eV
%       neff = effective principle quantum number
%       Elas = laser field strength in GV/m
%       Tlas = laser pulse length in fs
function [ nfrac ] = ADKfrac( Z, xi, Elas, Tlas )

n = neff(Z,xi); % effective principle quantum number

w = (1.52E15)*( (4^n)*xi/(n*gamma(2*n)) ).*...
    ( (20.5*(xi^1.5)./Elas).^(2*n-1) ).*...
    exp(-6.83*(xi^1.5)./Elas); % 1/s, ionization rate

nfrac = w.*(Tlas*1e-15); % fraction of atoms ionized

end