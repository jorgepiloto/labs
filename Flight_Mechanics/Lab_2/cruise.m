%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% CRUISE ANALYSIS  %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; clc; addpath('./subroutines');


%% Loading all the parameters
global p
p = parameters();

%% Initial conditions and state vector
x0 = 0; % Position
h0 = 10000; % Height
W0 = p(8); %Weight
v0 = 1.2 * (2 * p(8) / (ISA(h0) * p(2))) ^ 0.5 * (p(9) / p(5)) ^ 0.25; % Initial base velcocity

u0 = [v0, x0, h0, W0]; %Initial state vector


%% Solving ODE_Cruise
tspan = [0 3600]; % Time span for one hour
opts=[];
[t, u] = ode45(@ODE_Cruise, tspan, u0,opts,1); % Evolution of system

%% Ploting all the results
plot_title = ["Velocity along time", "Position along time", "Height along time", "Weight along time"];
plot_colors = ['b', 'r', 'k', 'y'];
for i=1:4
    subplot(2, 2, i)
    plot(t, u(:, i), plot_colors(i));
    title(plot_title(i));
    xlabel("Time [s]")
end
suptitle("State variables evolution");

%% Plotting non dimensional Thrust vs non dimensional velocity
T_max = p(6);
T = 1.0 * T_max * (ISA(h0) / ISA(0)) ^ 0.7 * ones(length(u(:, 3)));

V_hat_formula = 1.2:0.1:3.0;
T_hat_formula = 0.5 .* (V_hat_formula .^2 + 1 ./ V_hat_formula .^2);

[T_hat, V_hat, T_b, V_b] = from_d_2_nd(T, u(:, 1), p, u(:, 3), u(:, 4));
figure()
plot(V_hat, T_hat);
hold on
plot(V_hat_formula, T_hat_formula, 'k');
title("T_hat vs v_hat");

