function w_0 = WmFunction(x)
% W_m function (m = 0)

w_0 = exp(-x^2) * integral(@(y) exp(y.^2),0,x);