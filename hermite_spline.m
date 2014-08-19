% Generates a cubic Hermite interpolant in 'standard spline' output format.
% First row of the input matrix (A) corresponds to interpolation points.
% Second row of the input matrix (A) contains function values at interpolation points.
% Third row of the input matrix (A) contains derivative values at interpolation points.

function ans = hermitespline(n,A);

%Error Check that matrix is 3-by-n
dimensions = size(A);

if (dimensions(1,1) ~= 3) || (dimensions(1,2) ~= n)
	disp(sprintf('Error: Dimensions of input matrix are not 3xN'));
	return;
end

%Build vector of input nodes X
X = A(1,:);

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
ans = mkpp(X,C);

