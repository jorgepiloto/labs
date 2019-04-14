function dudt = ode_turn(t, u, xc)

global p;
g = 9.8; 
% u = [V, x, y, h, ji, W]
% Retrieve parameters
S = p(2);
CD0 = p(5);
k = p(9);
TmaxSL = p(6);
SFCT = p(7);

% Variables
V = u(1);
x = u(2);
y = u(3);
h = u(4);
ji = u(5);
W = u(6);

% Control vector
PI = xc(1);
mu = xc(2);

% Get state related variables
rhoSL = ISA(0);
rho = ISA(h);
T = PI * TmaxSL * (rho / rhoSL) ^ 0.7;
CL = W / (1/2 * rho * V ^ 2) / cos(mu);
D = 1/2 * rho * V ^ 2 * S * (CD0 + k * CL ^ 2);

L = 1/2 * rho * V ^ 2 * CL;

% Get the time derivatives
dudt = zeros(6,1);
dudt(1) = (T - D) * g / W;
dudt(2) = V * cos(ji);
dudt(3) = V * sin(ji);
dudt(4) = 0;
dudt(5) = L * g * sin(mu) / W / V;
dudt(6) = -SFCT * T;

end