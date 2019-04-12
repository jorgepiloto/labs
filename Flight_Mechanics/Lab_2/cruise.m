%% Main script
clear; clc;
addpath('./subroutines');

%% CRUISE CONDITIONS

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% LOADING ALL THE PARAMETERS %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global p
p = Parameters(); % Loading parameters
MTOW = p(8); % Maximum takeoff weight
S = p(2); % Surface of the aircraft
Cd0 = p(5); % Zero lift drag coefficient
k = p(9); % Induced drag coefficient



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% INITIAL CONDITIONS  %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initial conditions
x0 = 0;
H0 = 10000;
W0 = MTOW;
[Temp,a,P,rho] = atmosisa(H0); %Computing atmospheric properties
v0 = 1.2 * (2 * MTOW / (rho * S))^0.5 * (k / Cd0)^0.25; % Initial base velcocity

u0 = [v0, x0, H0, W0]; %Initial state vector


%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% SOLVE ODE CRUISE  %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%

tspan = [0 3600]; % Time span for one hour
opts=[];
[t, x] = ode45(@ODE_Cruise, tspan, u0,opts,1); % Evolution of system

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% PLOTTING RESULTS  %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%

plot_title = ["Velocity along time", "Position along time", "Height along time", "Weight along time"];
plot_colors = ['b', 'r', 'k', 'y'];
for i=1:4
    figure()
    plot(t, x(:, i), plot_colors(i));
    title(plot_title(i));
end

V = x(:, 1); % Cruise velocity
r = x(:, 2); % Position along time
h = x(:, 3); % Height along time
W = x(:, 4); % Weight along time

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% THRUST FOR CRUISE  %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
T_max = p(6);
[rho_cruise, ~, ~, ~] = ISA(10000);
[rho_sl, ~, ~, ~] = ISA(0);
T = 1.0 * T_max * (rho_cruise / rho_sl)^0.7 * ones(length(h), 1);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% NON DIMENSIONAL T & V  %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[T_hat,V_hat,T_b,V_b] = From_D_2_ND(T,V,p,h,W);
figure()
plot(V_hat, T_hat);




