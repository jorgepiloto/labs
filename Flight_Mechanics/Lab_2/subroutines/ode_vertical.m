function dudt = ode_vertical(t, u, xc)
%{

	The following function hold the dynamic system:

	Inputs
	------
	u: array
		[v, x0, h, W]
    
    Outputs
    -------
    dudt: array
        Derivative of previous array
%}

global p
g = 9.81; 

% Retrieve parameters
S = p(2);
CD0 = p(5);
k = p(9);
TmaxSL = p(6);
SFCT = p(7);

% Variables
V = u(1);
x = u(2);
h = u(3);
W = u(4);

% Control vector
PI = xc(1);
gamma = xc(2);

% Get state related variables
rhoSL = ISA(0);
rho = ISA(h);
T = PI * TmaxSL * (rho / rhoSL) ^ 0.7;
CL = 2 * W * cos(gamma) / (rho * S * V ^ 2);
D = 1/2 * rho * V ^ 2 * S * (CD0 + k * CL ^ 2);

% Get the time derivatives
dudt = zeros(4,1);
dudt(1) = (T - D - W * sin(gamma)) * g / W;
dudt(2) = V * cos(gamma);
dudt(3) = V * sin(gamma);
dudt(4) = -SFCT * T;

end