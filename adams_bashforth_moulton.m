% Applies the adams-bashforth-moulton predictor corrector method. 
% Note: y(1) corresponds to y0, due to MATLAB's counting starting at 1.

function ans = adams_bashforth(f,a,b,y0,h);

%Use Runge-Kutta to find y1,y2,y3
t = a:(h/2):b;  %vector of interpolation points
y = zeros(length(t),1);  %vector of y values
y(1) = y0;

for i = 1:3
	k1 = f(t(i),y(i));
	k2 = f((t(i)+0.5*h),(y(i)+0.5*h*k1));
	k3 = f((t(i)+0.5*h),(y(i)+0.5*h*k2));
	k4 = f((t(i)+h),(y(i)+k3*h));

	y(i+1) = y(i) + (1/6)*(k1+2*k2+2*k3+k4)*h;

end

if i == length(t)
	ans = y(i+1);
	return;
end

for i = 4:(length(t) - 1)
	%Apply Adams-Bashforth predictor
	p = y(i) + (h/24)*(55*f(t(i),y(i)) -59*f(t(i-1),y(i-1)) + 37*f(t(i-2),y(i-2)) - 9*f(t(i-3),y(i-3)));

	%Apply Adams-Moulton corrector
	y(i+1) = y(i) + (h/24)*(9*f(t(i+1),p) + 19*f(t(i),y(i)) - 5*f(t(i-1),y(i-1)) + f(t(i-2),y(i-2)));
end
disp(sprintf('Value: %e\n', y(i+1)));
