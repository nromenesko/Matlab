% Compares the numerical integration accuracy of 
% Guassian, Simpson's, and the Midpoint methods.
%
% @param actual = actual value of integral over interval [0,1]
% @param f = function to evaluate

function integration_comparison(actual, f);

%Approximate using Simpson's Rule with 2 subintervals
N = 2;
X = linspace(0,1,N);
sum = 0;

for iter = 1:N-1
	a = X(iter);
	b = X(iter + 1);
	mid = (a+b)/2;
	
	I = ((b-a)/6) * (f(a) + 4*f(mid) + f(b));
	sum = sum + I;
end
disp(sprintf('Simpsons Rule Error:  %f\n', abs(sum-actual)));


%Approximate using Composite Midpoint Rule with 2 subintervals
N = 2;
X = linspace(0,1,N);
sum = 0;

for iter = 1:N-1
	a = X(iter);
	b = X(iter + 1);
	mid = (a+b)/2;
	
	I = f(mid) * (b-a);
	sum = sum + I;
end
disp(sprintf('Composite Midpoint Rule Error:  %f\n', abs(sum-actual)));


%Approximate using Guassian method with N = 2
%Find the weights of each point (pattern from part b)
w0 = -f(0);
w1 = f(1);
g = @(x) x.^2 -(1/2)*x - (1/12);

gauss = w0*g(0) + w1*g(1);
disp(sprintf('Gaussian Error:  %f\n', abs(gauss-actual)));