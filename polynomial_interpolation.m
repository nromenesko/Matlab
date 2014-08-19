% Interpolates function f in three different ways over the 
% interval [a,b] using n interpolation points.The function plots the error
% of each method, and returns a divided differences table for each
%
% The three methods of interpolation:
%(1) Polynomial interpolation at n equidistant points on [a,b]
%(2) Polynomial interpolation at n Chebyshev points
%(3) Cubic Spline interpolation at n equidistant points

function multinterpolation(a,b,n,f);

%Calculate equally spaced interpolation points, and the values of f at these points
x_equidist = linspace(a,b,n);
y_equidist = f(x_equidist);

%Calculate the Chebyshev points, and the values of f at these points
x_chebyshev = linspace(a,b,n);
for i = 1:n
	x_chebyshev(i) = ((a+b)/2)  - (((b-a)/2) * cos(((2*i - 1)/(2*n))* pi));
end

y_chebyshev = f(x_chebyshev);

%Generate Divided-Difference tables
table1 = zeros(n+1);
table2 = zeros(n+1);

%Populate Divided-Difference tables for methods 1 and 2
for j = 1:n+1

	%Calculate values for each row in column j
	for i = 1:(n - j)
	
		%First column contains x-values
		if j == 1
			table1(i,1) = x_equidist(1,i);
			table2(i,1) = x_chebyshev(1,i);
			
		%Second column contains y-values
		elseif j == 2
			table1(i,2) = y_equidist(1,i);
			table2(i,2) = y_chebyshev(1,i);
			
		else
			%Calculate individual cell values for equidistant points
			table1(i,j) = (table1(i,j-1) - table1(i+1,j-1))/(table1(i,1) - table1(i+(j-1),1));
			
			%Calculate individual cell values for Chebyshev points
			table2(i,j) = (table2(i,j-1) - table2(i+1,j-1))/(table2(i,1) - table2(i+(j-1),1));
		end
	end
end

z = linspace(a,b,5*n);

%Evaluate interpolation methods 1 and 2 using nested multiplication
newton_val = linspace(a,b,5*n);
cheby_val = linspace(a,b,5*n);
for iter = 1:(5*n)

	%Running totals for nested multiplications (Initialized with value of last coefficient)
	total1 = table1(1,n+1);
	total2 = table2(1,n+1);

	column = n;		%Used to point to current coeff in DD table
	row = n;		%Used to point to current x-value in DD table
	
	while column > 1

		total1 = table1(1,column) + (z(iter) - table1(row,1) * total1);
		total2 = table2(1,column) + (z(iter) - table2(row,1) * total2);
		column = column - 1;
		row = row - 1;
		
	end
	
	%store values in their respective vectors
	newton_val(iter) = total1;
	cheby_val(iter) = total2;
end

%Perform Spline Interpolation
p = spline(x_equidist, y_equidist, z);

%Plot the Errors of Each Method
error = abs(f(z) - p);			%Error of Spline plotted
plot(z, error, '--r')		
hold on 

error = abs(f(z) - newton_val);	%Error of Newton's method
plot(z, error, 'b')	

error = abs(f(z) - cheby_val); %Error of Chebychevs
plot(z, error, ':g')

%Make the graph look nice
title('Graph of Error');
xlabel('x-value');
ylabel('Error');
%Print Divided difference tables
newtons = table1
chebychev = table2
