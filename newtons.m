% Newton's root finding algorithm. 
%   x: root estimate
%   f: function to solve
%   dff: derivative of f    

function newtons(x,f,ddf);

tolerance = 10^-4;
max = 1000;

for iteration = 1:max
	iteration
	x = x - (f(x)/ddf(x));
	disp(sprintf('Value: %.9f', x));
	
	% If f(x) evaluates to 0, we have found a root
	if (abs(f(x)) < tolerance)
		disp(sprintf('\n--- The function converged ---\nIteration: %d\nValue: %f', iteration, x));
		return
	end
end

%If we reach the end without finding a root
disp(sprintf('Error: Could not find a root after %d iterations.', max));