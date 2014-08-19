% Bisection root finding algorithm.
%     f: function to solve
%   a,b: points within the domain of the function. 
%        f(a) and f(b) should have differing signs.

function bisection(a,b,f);

max = 1000;

for iteration = 1:max

	mid = (a + b)/2;
	
	if (f(a) * f(mid) < 0)
		b = mid;
		
	elseif (f(b) * f(mid) < 0)
		a = mid;
        
	else
		disp(sprintf('\n--- The function converged ---\nIteration: %d\nValue: %f', iteration, mid));
		return
	end
end

%If we reach the end without finding a root
disp(sprintf('Error: Could not find a root after %d iterations.', max));