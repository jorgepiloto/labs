function xc = fun_control(flag, p)

%{

	The following function returns the control vector for a given
	simulation:

	Inputs
	------
	flag: int
		1: Cruise
		2: Vertical
		3: Turn
    p: array
        Parameters list

	Outputs
	-------
	xc: array
		Contains [PI, angle]

%}

if flag == 0
	% We have cruise conditions
	xc = [1.0];
end

if flag == 1
	% We have vertical conditions
	PI = 0.5;
	gamma = deg2rad(-2);
	xc = [PI, gamma];
end

if flag == 2
	% We hace turn conditions
	T_hat = 1.2;
	V_hat = 1.1;

	mu = acos(1 / (V_hat * sqrt(2 * T_hat - ( V_hat ^ 2))));
	T = T_hat * 2 * sqrt(p(9) * p(5)) * p(8);

	PI = T / p(6) * (ISA(0) / ISA(10000)) ^ 0.7;
	xc = [PI, mu];
end

end
