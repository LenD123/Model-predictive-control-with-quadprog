function [AA,BB,QQ,RR] = augmentedSystemAndCostMatrices(A,B,Q,R,S,N)
% computes augmented system matrices and cost matrices

%% get dimensions
[n,m]=size(B);

%% check input
if size(A,1)~=n || size(A,2)~=n
    error('dimension mismatch for A')
end
if size(Q,1)~=n || size(Q,2)~=n
    error('dimension mismatch for Q')
end
if size(R,1)~=m || size(R,2)~=m
    error('dimension mismatch for R')
end
if size(S,1)~=n || size(S,2)~=n
    error('dimension mismatch for S')
end
if round(N)~=N || N<1
   error('N should be an integer value greater 0')
end

%% allocate
AA=zeros((N+1)*n,n);
BB=zeros((N+1)*n,N*m);
QQ=zeros((N+1)*n,(N+1)*n);
RR=zeros(N*m,N*m);

%% compute matrices
for k=0:N
    AA(k*n+1:(k+1)*n,:)=A^k;
    for j=0:k-1
        BB(k*n+1:(k+1)*n,j*m+1:(j+1)*m)=A^(k-j-1)*B;
    end
    if k<N
        QQ(k*n+1:(k+1)*n,k*n+1:(k+1)*n)=Q;
        RR(k*m+1:(k+1)*m,k*m+1:(k+1)*m)=R;
    else
        QQ(k*n+1:(k+1)*n,k*n+1:(k+1)*n)=S;
    end
end