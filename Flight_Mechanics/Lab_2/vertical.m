%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% VERTICAL ANALYSIS  %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; clc; addpath('./subroutines');

%% Loading all the parameters
global p
p = parameters();


%% Task 1a
performance = figure;
gamma_span = deg2rad([-25, -10, -2, 0, 2]); % Different descent configurations
V_hat= 0.1:0.1:3.0;

figure(performance);
for i=1:length(gamma_span)
    T_hat = per_vertical(V_hat, gamma_span(i));
    plot(V_hat, T_hat, 'k');
    hold on;
end
title("T_h vs V_h for different gamma");
xlabel("V_h");
ylabel("T_h");

% Inital conditions and control inputs
PI = 0.5;
gamma = deg2rad(-2);
xc = [PI, gamma];
x0 = 0; 
h0 = 15000; 
W0 = p(8);
v0_span = [0.5, 1.2];

state_variables = figure;


for n = 1 : length(v0_span)
    v0 = v0_span(n) * (2 * p(8) / (ISA(h0) * p(2))) ^ 0.5 * (p(9) / p(5)) ^ 0.25; % Initial base velcocity
    u0 = [v0, x0, h0, W0];

    % Solving ODE
    tspan = [0 900]; % Time span for 15 min (900 [s])
    [t, u] = ode45(@(t, u) ode_vertical(t, u, xc), tspan, u0); % Evolution of system

    % Ploting the results for state variables
    plot_title = ["Velocity along time", "Position along time", "Height along time", "Weight along time"];
    plot_colors = ['b', 'r'];
    y_label_span = ["[m/s]", "[m]", "[m]", "[kg]"];
    
    figure(state_variables)
    for i = 1 : 4
        subplot(4, 1, i)
        plot(t, u(:, i), plot_colors(n), 'linewidth', 1.5);
        title(plot_title(i));
        xlabel("Time [s]");
        ylabel(y_label_span(i));
        legend("0.5Vem", "1.2Vem");
        hold on;
    end


    % Plotting non dimensional Thrust vs non dimensional velocity
    T_max = p(6);
    T = PI * T_max * (ISA(h0) / ISA(0)) ^ 0.7 * ones(length(u(:, 3)));
    [T_hat, V_hat, T_b, V_b] = from_d_2_nd(T, u(:, 1), p, u(:, 3), u(:, 4));

    figure(performance)
    plot(V_hat, T_hat, plot_colors(n), 'linewidth', 1.5);
    hold on
end

V_hat = 0.1:0.1:3.0;
T_hat = per_vertical(V_hat, deg2rad(-2));
plot(V_hat, T_hat, 'g', 'linewidth', 1.5);
title("Performance equations");
xlabel("V_h");
ylabel("T_h");










