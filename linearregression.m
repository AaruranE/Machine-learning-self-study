%Implements a basic linear regression on some random numbers

N = 50;
x= (1:N).';

Maxerror=3;
error = Maxerror*(rand(size(x))-0.5*(ones(size(x))));

slope = 3;
intercept = 1;
y = (3 + rand-0.5)*x + error + intercept*ones(size(x));
%plot(y)

degree = 3;

X = zeros(N,degree+1);

for k = 1:degree+1
    X(:,k) = x.^k;
end
% X(:,1) = ones(1,N);
% X(:,2) = x;

square = X.'*X;
polycoeff = square\X.'*y;

yguess = X*polycoeff;

plot(x,y,'.',x,yguess)

