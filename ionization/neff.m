%% effective ionization level
% inputs: Z = atomic number
%         Ui = ionization energy in eV
function [ neff ] = neff( Z, Ui )
% From M. Litos

AU_consts;
neff = sqrt(AU_Eh)*Z/sqrt(Ui);

end

