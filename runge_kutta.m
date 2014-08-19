% Applies the Runge-Kutta method. 
% Note: y(1) corresponds to y0, due to MATLAB's counting starting at 1.

function ans = runge(f,a,b,y0,h);

%Use Runge-Kutta to find y1,y2,y3
t = a:h:b;  %vector of interpolation points
y = zeros(4,1);  %vector of y values
y(1) = y0;

for i = 1:(length(t)-1)
	k1 = f(t(i),y(i));
	k2 = f((t(i)+0.5*h),(y(i)+0.5*h*k1));
	k3 = f((t(i)+0.5*h),(y(i)+0.5*h*k2));
	k4 = f((t(i)+h),(y(i)+k3*h));

	y(i+1) = y(i) + (1/6)*(k1+2*k2+2*k3+k4)*h;

end
disp(sprintf('Value: %e\n', y(i+1)));