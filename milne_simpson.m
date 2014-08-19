% Applies the milne-simpson predictor corrector method. 
% Note: y(1) corresponds to y0, due to MATLAB's counting starting at 1.

function milne_simpson(f,a,b,y0,h);

%Use Runge-Kutta to find y1,y2,y3
t = a:(h/2):b;           %vector of interpolation points
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
	%Use Milne's rule as the predictor
	p = y(i-3) + (4*h/3)*(2*f(t(i-2),y(i-2)) - f(t(i-1),y(i-1)) + 2*f(t(i),y(i)));

	%Apply Simpson's rule as the corrector
	y(i+1) = y(i-1) + (h/3)*(f(t(i-1),y(i-1)) + 4*f(t(i),y(i)) + f(t(i+1),p));
end
disp(sprintf('Value: %e\n', y(i+1)));