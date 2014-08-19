%This function performs the vandermonde approach to solving polynomial interpolation
%Input: Function f(x) to interpolate, Single-column vector X containing values on the interval to interpolate

function ans = vandermonde(X,f);

d = size(X);
height = d(1,1);
max_iter = height;

%Create Vandermonde and function-value matrix
V = zeros(height, height);
Y = zeros(height,1);

for row = 1:max_iter

	%Current x-value for on the interval
	cell = X(row,1);
	for column = 1:max_iter
		
		power = max_iter - column;			%Power to raise x-value to
		V(row,column) = cell^(power);	%Populate the Vandermonde matrix
		
	end
	
	%populate the function-value matrix
	Y(row,1) = f(cell);
end

%Solve system of equations and return a matrix of the coefficients
ans = V\Y;
	
	