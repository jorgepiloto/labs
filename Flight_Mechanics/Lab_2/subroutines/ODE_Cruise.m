function dudt = ODE_Cruise(t,u,xc)
%% INPUTS
% t    -->  Time
% u    -->  State vector 
% u(1) -->  V (velocity)   [m/s]
% u(2) -->  x (Position)   [m]
% u(3) -->  h (Height)     [m]   
% u(4) -->  W (Weight)     [N]
% xc   -->  Thrust level   [-]
%% OUTPUTS
% dudt -->  Time derivative of u
%% MAIN
global p
g = 9.81; 

% Retrieve parameters
S = p(2);
CD0 = p(5);
k = p(9);
TmaxSL = p(6);
SFCT = p(7);

% Get state related variables
rhoSL = ISA(0);
rho = ISA(u(3));
T = xc*TmaxSL*(rho/rhoSL)^0.7;
CL = u(4)/(1/2*rho*u(1)^2*S);
D = 1/2*rho*u(1)^2*S*(CD0+k*CL^2);
W = u(4);
V = u(1);

% Get the time derivatives
dudt = zeros(4,1);
dudt(1) = (T-D)*g/W;
dudt(2) = V;
dudt(3) = 0;
dudt(4) = -SFCT*T;


end