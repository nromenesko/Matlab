% Secant method root finding algorithm.

function secant(x0,x1,f);

tolerance = 10^-5;  % Error tolerance
max = 1000;         % Max number iterations

for iteration = 1:max

	x2 = x1 - (f(x1)*(x1-x0))/(f(x1) - f(x0));
	x0 = x1;
	x1 = x2;
	
	% If f(x2) evaluates to 0, we have found a root
	if (abs(f(x2)) < tolerance)
		disp(sprintf('\n--- The function converged ---\nIteration: %d\nValue: %f', iteration, x2));
		return
	end
end

%If we reach the end without finding a root
disp(sprintf('Error: Could not find a root after %d iterations.', max));
