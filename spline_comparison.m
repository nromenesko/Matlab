% Interpolates a function f uing both Cubic Splines and Cubic Hermite Splines, and plots the errors.
%
%   [a,b]: interval of interpolation 
%       n: number of points to interpolate
%       f: function to interpolate
%	   df: derivative of f

function splinecomparison(a,b,n,f,df);

x_equidist = linspace(a,b,n);	
y_equidist = f(x_equidist);

%First row of A corresponds to interpolation points.
A(1,:) = x_equidist;

%Second row of A contains function values at interpolation points.
A(2,:) = y_equidist;

%Third row of A contains derivative values at interpolation points.
A(3,:) = df(x_equidist);

%Build coefficient matrix C
for iter = 1:(n-1)
	%Create variables for readability
	x0  = A(1,iter);
	x1  = A(1, iter+1);
	fx0 = A(2,iter);
	fx1 = A(2, iter+1);
	dx0 = A(3,iter);
	dx1 = A(3, iter+1);

	%Calculate third column of Divided Diff table:
	row1 = (dx0 - ((fx0-fx1)/(x0-x1))) / (x0-x1);
	row2 = (((fx0-fx1)/(x0-x1)) - dx1) / (x0-x1);
	
	%Calculate last column of Divided Diff table:
	coeff1 = (row1 - row2)/(x0-x1);
	
	%Coefficient a_2 = a_~2 - a_~1(x1-x0)
	coeff2 = row1 - coeff1*(x1-x0);
	
	%Use divided difference values to fill in current row of coefficient matrix
	C(iter,:) = [coeff1,coeff2,dx0,fx0];
end

%use mkpp to create spline
herm = mkpp(x_equidist,C);

%Perform Spline Interpolation
p = spline(x_equidist, y_equidist);

%dense mesh of points over the interval [a,b]
z = linspace(a,b);

%evaluate spline and hermite spline over the interval
s = ppval(p,z);
h = ppval(herm,z);

%Calculate and plot the Errors of Each Method
spline_error = abs(f(z) - s);			
herm_error = abs(f(z) - h);

plot(z, spline_error, '--r')
hold on 
plot(z, herm_error, 'b')	

%Make the graph look nice
title('Graph of Error');
xlabel('x-value');
ylabel('Error');

hold off

%Graph Spline and Hermite SPline Interpolants
figure
plot(z, s, '--r')
hold on 
plot(z, h, 'b')	

%Make the graph look nice
title('Graph of Interpolants');
xlabel('x-value');
ylabel('y-value');