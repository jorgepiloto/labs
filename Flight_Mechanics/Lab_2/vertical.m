%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% VERTICAL ANALYSIS  %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; clc; addpath('./subroutines');

%% Loading all the parameters
global p
p = parameters();


%% Task 1a
gamma_span = deg2rad([-25, -10, -2, 0, 2]); % Different descent configurations
V_hat= 0.1:0.1:3.0;
figure();
for i=1:length(gamma_span)
    T_hat = performance_vertical(V_hat, gamma_span(i));
    plot(V_hat, T_hat);
    hold on;
end
title("T_h vs V_h for different gamma");
legend("-25º", "-10º", "-2º", "0º", "2º");

%% Task 2c
x0 = 0; % Position
h0 = 15000; % Height
W0 = p(8); %Weight
v0 = 1.2 * (2 * p(8) / (ISA(h0) * p(2))) ^ 0.5 * (p(9) / p(5)) ^ 0.25; % Initial base velcocity
u0 = [v0, x0, h0, W0];

%% Task 2d
PI = 0.5;
gamma = deg2rad(-2);
xc = [PI, gamma];

tspan = [0 900]; % Time span for 15 min (900 [s])
[t, u] = ode45(@(t, u) ode_vertical(t, u, xc), tspan, u0); % Evolution of system

plot_title = ["Velocity along time", "Position along time", "Height along time", "Weight along time"];
plot_colors = ['b', 'r', 'k', 'y'];
figure();
for i=1:4
    subplot(2, 2, i)
    plot(t, u(:, i), plot_colors(i));
    title(plot_title(i));
    xlabel("Time [s]")
end
suptitle("State variables evolution descending");

%% Plotting non dimensional Thrust vs non dimensional velocity
T_max = p(6);
T = PI * T_max * (ISA(h0) / ISA(0)) ^ 0.7 * ones(length(u(:, 3)));

figure()
[T_hat, V_hat, T_b, V_b] = from_d_2_nd(T, u(:, 1), p, u(:, 3), u(:, 4));
plot(V_hat, T_hat, 'k');
hold on
V_hat = 0.1:0.1:3.0;
T_hat = performance_vertical(V_hat, deg2rad(-2));
plot(V_hat, T_hat);
title("T_h vs V_h comparation");









