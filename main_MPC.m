% Classical MPC without terminal ingredients
%% 
clc; clear all;
%%

%dynamics and constraints:
A = [1, 1; 0, 1];
B = [0.5; 1];
x0 = [20; 2];

uLb = -1;
uUb = 1;
xLb = [-25; -5];
xUb = [25; 5];

%prediction horizon and weightings
N = 10;
Q = 0.1*eye(2);
S = 2*Q;
R = 1;

%QP Setup
[AA,BB,QQ,RR] = augmentedSystemAndCostMatrices(A,B,Q,R,S,N);
[ULb,UUb,XLb,XUb] = augmentedConstraintVectors(uLb,uUb,xLb,xUb,N);

%% Simulation
kEnd = 20;
X = [x0, zeros(numel(x0), N)];
U = zeros(N, numel(uLb));

for k = 1:kEnd
   [H,f, G, e] = setQPmpc(AA,BB,X(:,k), QQ, RR, N, ULb, UUb, XLb, XUb);
   zOpt = quadprog(H,f',G,e);
   U(k) = zOpt(1);
   
   X(:,k+1) = A*X(:,k) + B*U(k);
end

figure (1)
plot(0:k,X(1,:),'k') 
hold on
plot(0:k,X(2,:),'m')
grid on
figure(2)
stairs(0:k-1, U)
grid on