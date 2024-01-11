function [H,f, G, e] = setQPmpc(AA,BB,x0, QQ, RR, N, ULb, UUb, XLb, XUb)
%QPMPC formulates QP matrices for min_U 1/2 z'Hz + f'z s.t. Gz <= e for classical setpoint MPC
m = 1;

H = 2*(RR+BB'*QQ*BB);
G = [eye(N*m); -eye(N*m); BB; -BB];
f = 2*BB'*QQ*AA*x0;
e = [UUb; -ULb; XUb - AA*x0; -XLb + AA*x0];

end

