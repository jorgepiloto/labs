function dudt = ode_turn(t, u, xc)

global p;

% Vector u = [V, x, h, W, y, chi]
V = u(1);
x = u(2);
h = u(3);
W = u(4);
y = u(5);
chi = u(6);

% Parameters
S = p(2);
Cd0 = p(5);
k = p(9);
SFC = p(7);
g = 9.81;
Tmax = p(6);

% Densities
rho = ISA(h);
rho0 = ISA(0);

% Control variables
xc = fun_control(1, p);
PI = xc(1);
mu = xc(2);

% Compute forces
CL = 2 * W / (cos(mu) * rho * S * V ^ 2); 
T = PI * Tmax * (rho / rho0) ^ 0.7;
L = 0.5 * rho * V ^ 2 * S * CL;
CD = Cd0 + k * CL ^ 2;
D = 0.5 * rho * V ^ 2 * S * CD;

% Derivatives
% Vector u = [V, x, h, W, y, chi]
dudt = zeros(6, 1);
dudt(1) = (T - D) * g / W;     
dudt(2) = V * cos(chi);          
dudt(3) = 0;                   
dudt(4) = -SFC * T;            
dudt(5) = V * sin(chi);
dudt(6) = -(L / W) * (g / V) * sin(mu); 





















end