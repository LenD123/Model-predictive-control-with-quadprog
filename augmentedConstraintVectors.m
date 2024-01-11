function [ULb,UUb,XLb,XUb] = augmentedConstraintVectors(uLb,uUb,xLb,xUb,N)
% computes augmented constraint vectors

%% stack the vectors uLb, uUb, xLb, xUb each N times
ULb=repmat(uLb,N,1);
UUb=repmat(uUb,N,1);
XLb=repmat(xLb,N+1,1);
XUb=repmat(xUb,N+1,1);

end