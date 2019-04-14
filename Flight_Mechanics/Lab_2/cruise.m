% Cruise Analysis

clear; clc; addpath('./subroutines');
global p

% Parameters and initial conditions
p = parameters();
x0 = 0; % Position
h0 = 10000; % Height
W0 = p(8); %Weight
v0_span = [0.4, 0.6, 1.2];

state_variables = figure;
performance = figure;

for n = 1 : length(v0_span)
    v0 = v0_span(n) * (2 * p(8) / (ISA(h0) * p(2))) ^ 0.5 * (p(9) / p(5)) ^ 0.25; % Initial base velcocity
    u0 = [v0, x0, h0, W0];
    
    % Solving ODE
    tspan = [0 3600]; % Time span for one hour
    opts=[];
    [t, u] = ode45(@ode_cruise, tspan, u0, opts,1); % Evolution of system

	% Ploting the results for state variables
    plot_title = ["Velocity along time", "Position along time", "Height along time", "Weight along time"];
    plot_colors = ['b', 'r', 'k'];
    y_label_span = ["[m/s]", "[m]", "[m]", "[kg]"];
    
    figure(state_variables)
    for i = 1 : 4
        subplot(4, 1, i)
        plot(t, u(:, i), plot_colors(n), 'linewidth', 1.5);
        title(plot_title(i));
        xlabel("Time [s]");
        ylabel(y_label_span(i));
        legend("0.4Vem", "0.6Vem", "1.2Vem");
        hold on;
    end
    
    % Plotting the results for performance variables
    PI = 1.0;
    T_max = p(6);
    T = PI * T_max * (ISA(h0) / ISA(0)) ^ 0.7 * ones(length(u(:, 3)));
    [T_hat, V_hat, T_b, V_b] = from_d_2_nd(T, u(:, 1), p, u(:, 3), u(:, 4));
    
    figure(performance)
    plot(V_hat, T_hat, plot_colors(n), 'linewidth', 1.5);
    hold on;
end

V_hat = 0.1 : 0.1 : 3.0;
T_hat = per_cruise(V_hat, 0);
plot(V_hat, T_hat, 'g', 'linewidth', 1.5);
title("Performance equations");
xlabel("V_h");
ylabel("T_h");


