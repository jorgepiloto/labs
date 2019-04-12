%%%%%%%%%%%%%%%%%%%%%%%%
%%%% TURN ANALYSIS  %%%%
%%%%%%%%%%%%%%%%%%%%%%%%

clear; clc; addpath('./subroutines');


%% Loading all the parameters
global p
p = parameters();

%% Generating contour plots
vspan_hat = 0.1:0.1:2.5;
Tspan_hat = 0.1:0.1:4;
[V_hat, T_hat] = meshgrid(vspan_hat, Tspan_hat);
contour_titles = ["Mu", "Load factor", "Normalized turn rate", "log10 Minimum radius"];
n_factor = V_hat .* sqrt(2 .* T_hat - V_hat .^ 2);
turn_rate = sqrt(2 .* T_hat - V_hat .^ 2 - 1 ./ V_hat .^ 2);
Rg_vEm = log10(1 ./ sqrt(2 .* T_hat ./ V_hat .^ 2 - 1 - 1 ./ V_hat .^4));
mu = acos(1 ./ T_hat);

Z = {mu, n_factor, turn_rate, Rg_vEm}; % Variables to be ploted

for i=1:length(contour_titles)
    subplot(2, 2, i);
    contourf(V_hat, T_hat, real(Z{i}), 'ShowText','on');
    colormap(autumn);
    title(contour_titles(i));
end
suptitle("Performance on aircraft turning");

%% Compute PI and bank angle
h0 = 10000;
V_hat = 1.1;
T_hat = 1.2;

mu = acos(1 / T_hat);
[T0, V0, T_b, V_b] = from_nd_2_d(T_hat, V_hat, p, h0, p(8));

PI = (T0 / p(6)) * (ISA(0) / ISA(h0)) ^ 0.7;

%% Solving ode_turn
tspan = [0 5*3600];
x0 = 0;
y0 = 0;
ji0 = 0;
u0 = [V0, x0, y0, h0, ji0, p(8)];
xc = [PI, mu];

[t, u] = ode45(@(t, u) ode_turn(t, u, xc), tspan, u0); % Evolution of system

%% Ploting all the results

plot_title = ["Velocity", "$\Xi$", "W"];
plot_colors = ['b', 'r', 'k'];

figure();

vars = {u(:,1), u(:,5), u(:,6)};
for i=1:3
    subplot(2, 2, i)
    plot(t, vars{i}, plot_colors(i));
    title(plot_title(i));
    xlabel("Time [s]")
end
subplot(2, 2, 4)
plot(u(:,3), u(:,2), 'y');
title("X vs Y");
suptitle("State variables evolution descending");

%% Plotting T_hat vs V_hat
%% Plotting non dimensional Thrust vs non dimensional velocity
T_max = p(6);
T = PI * T_max * (ISA(h0) / ISA(0)) ^ 0.7 * ones(length(u(:, 3)));

figure()
[T_hat, V_hat, T_b, V_b] = from_d_2_nd(T, u(:, 1), p, u(:, 4), u(:, 6));
plot(V_hat, T_hat, 'b');

V_hat = 0.1:0.1:3.0;
T_hat = 1/2 .* (V_hat .^ 2 + 1 ./ V_hat .^ 2 / cos(mu) .^ 2);
plot(V_hat, T_hat, 'k');


    
    
    
    
    
    
    