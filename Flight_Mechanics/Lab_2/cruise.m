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

% The initial velocity should be studied for: 0.4, 0.6 and 1.2 times Vem
v0 = 0.4 * (2 * p(8) / (ISA(h0) * p(2))) ^ 0.5 * (p(9) / p(5)) ^ 0.25; % Initial base velcocity

u0 = [v0, x0, h0, W0]; %Initial state vector


%% Solving ODE_Cruise
tspan = [0 3600]; % Time span for one hour
opts=[];
[t, u] = ode45(@ode_cruise, tspan, u0, opts,1); % Evolution of system

%% Ploting all the results
plot_title = ["Velocity along time", "Position along time", "Height along time", "Weight along time"];
plot_colors = ['b', 'r', 'k', 'y'];
for i=1:4
    subplot(4, 1, i)
    plot(t, u(:, i), plot_colors(i));
    title(plot_title(i));
    xlabel("Time [s]")
end
suptitle("State variables evolution");

%% Plotting non dimensional Thrust vs non dimensional velocity
PI = 1.0;
T_max = p(6);
T = PI * T_max * (ISA(h0) / ISA(0)) ^ 0.7 * ones(length(u(:, 3)));

V_hat_performance = 1.2:0.1:3.0;
T_hat_performance = performance_vertical(V_hat_performance, 0);

[T_hat, V_hat, T_b, V_b] = from_d_2_nd(T, u(:, 1), p, u(:, 3), u(:, 4));
figure()
title("T_hat vs V_hat");
xlabel("V_hat");
ylabel("T_hat");

plot(V_hat, T_hat);
hold on
plot(V_hat_performance, T_hat_performance);
legend('Simulation', 'Performance');

%% 

