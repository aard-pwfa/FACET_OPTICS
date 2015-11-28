function PSI_out = Aberations(rr,phi,input,PSI_in,r_max)

if input.zern_m == 0 && input.zern_n == 0 
    PSI_out = PSI_in;  
else
    r_norm = rr/r_max;
    index  = true(size(r_norm));
    index(r_norm>1) = false;
    zern   = zeros(size(r_norm));
    
    zern(index) = zernfun(input.zern_n,input.zern_m,r_norm(index),phi(index));
    
    PSI_out = PSI_in + input.zern_amp*(2*pi*r_max*zern)/input.lambda;
    
end
