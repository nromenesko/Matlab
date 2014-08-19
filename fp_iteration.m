% Runs the fixed-point iteration root finding algorithm with x0 as the initial guess

function ans = fp(x0, func);

tolerance = 10^-10;     % Error tolerance
xold = x0;
max = 1000;

for iteration = 1:max

	xnew = func(xold)
	
	% Test for convergence
	if abs(xnew-xold) <= tolerance
		disp(sprintf('--- The function converged ---\nIteration: %d\nValue: %f', iteration, xnew);
		break;
	end
	
	% Can't test for divergence yet, need more iterations
	if iteration == 1
		err_old = xnew - xold
	
	% Test for divergence
	else
		%ratio: err_curr/err_old	 = (xn+1 - xn) / (xn - xn-1)
		err_curr = xnew - xold;
		err_ratio = err_curr/err_old;
		err_old = err_curr
		
		% If error ratio is greater than one, the function is diverging
		% Note: A ratio of 1 could mean either very slow divergence or convergence
		if err_ratio > 1
			X = fprintf('The function diverged at iteration %d\n(Error Ratio greater than one)', iteration);
			break;
		end
	end
	
	% If last iteration and no convergence reached
	if iteration == max
		X = fprintf('The function did not reach convergence after %d iterations', max);
		disp(X)
		break;
	end
	
	xold = xnew;
end
ans = xnew;