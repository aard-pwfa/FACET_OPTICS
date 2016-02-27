%% effective ionization level
% inputs: Z = atomic number
%         xi = ionization energy in eV
function [ neff ] = neff( Z, xi )

neff = 3.69*Z/sqrt(xi);

end

