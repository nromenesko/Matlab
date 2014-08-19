%Calculates the polynomial and spline least-square error using the two-norm of the
%error vectors.
% @param f = function to evaluate
% @param m = total # equidistant points to evaluate
%
function [norm(vErr), norm(spErr)] = problem1(f,m,a);

% Get m equidistant points
X = linspace(0,2,m)';
z = linspace(0,2);		%z is a dense mesh of points over [0,2]


% Add noise to function evaluations
noise = a*(rand(1,m)-.5);
noisyY = f(X) + noise';


%Get least-squares polynomial approximation
V = vander(X);
vApprox = V\noisyY;
vEval = polyval(vApprox, z);	%Evaluate polynomial over dense mesh of points


%Get least-squares spline approximation
knots = aptknt(X,4);    		%generate acceptable knots for degree 4
sp = spap2(knots,4,X,noisyY);
spEval = spval(sp,z);			%Evaluate spline over dense mesh of points


%Calculate Error and divide by sqrt(m) to neutralize error growing with m
z = linspace(0,2);
vErr = abs(f(z) - vEval)/sqrt(m);
spErr = abs(f(z) - spEval)/sqrt(m);


%Print the 2-norm of each error
disp(sprintf('Polynomial Least Squares Error:  %f\n', norm(vErr)));
disp(sprintf('Spline Least Squares Error:  %f\n', norm(spErr)));


%Plot Errors
plot(z, vErr, '--r')
hold on 
plot(z, spErr, 'b')	
hold off


%Make the graph look nice
title('Graph of Error');
xlabel('x-value');
ylabel('Error');
