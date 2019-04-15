% Turn analysis

clear; clc; addpath('./subroutines');
global p

% Loading all the parameters and initial conditions
p = parameters();

% Generating contour plots
vspan_hat = 0.1:0.1:2.5;
Tspan_hat = 0.1:0.1:4;
[V_hat, T_hat] = meshgrid(vspan_hat, Tspan_hat);
contour_titles = ["Mu", "Load factor", "Normalized turn rate", "log10 Minimum radius"];
n_factor = V_hat .* sqrt(2 .* T_hat - V_hat .^ 2);
turn_rate = sqrt(2 .* T_hat - V_hat .^ 2 - 1 ./ V_hat .^ 2);
Rg_vEm = log10(1 ./ sqrt(2 .* T_hat ./ V_hat .^ 2 - 1 - 1 ./ V_hat .^4));
mu = acos(1 ./ T_hat);

Z = {mu, n_factor, turn_rate, Rg_vEm}; % Variables to be ploted

figure()
for i=1:length(contour_titles)
    subplot(4, 1, i);
    contourf(V_hat, T_hat, real(Z{i}), 'ShowText','on');
    colormap(autumn);
    title(contour_titles(i));
end

% Solve ODE
T_hat = 1.2;
V_hat = 1.1;
h0 = 10000;
[T0, V0, Tb, Vb] = from_nd_2_d(T_hat, V_hat, p, h0, p(8));

xc = fun_control(2, p);
tspan = [0 18000];
x0 = 0;
y0 = 0;
chi0 = 0;

% Vector u = [V, x, h, W, y, chi]
u0 = [V0, x0, h0, p(8), y0, chi0];

[t, u] = ode45(@(t, u) ode_turn(t, u, xc), tspan, u0, odeset('RelTol',1e-10)); % Evolution of system

%% Ploting all the results

plot_title = ["Velocity", "\chi", "W"];
plot_colors = ['b', 'r', 'k'];

% Vector u = [V, x, h, W, y, chi]
figure();
vars = {u(:,1), u(:,6), u(:,4)};
for i=1:3
    subplot(3, 1, i)
    plot(t, vars{i}, plot_colors(i), 'linewidth', 1.5);
    title(plot_title(i));
    xlabel("Time [s]")
end

figure()
plot(u(:,2) / 1000, u(:,5) / 1000, 'k');
xlabel("X [km]");
ylabel("Y [km]");
title("X vs Y");

% Performance computation

figure()
T = xc(1) * p(6) * (ISA(h0) / ISA(0)) ^ 0.7;
[T_hat, V_hat, T_b, V_b] = from_d_2_nd(T, u(:,1), p, h0, u(:, 4));
plot(V_hat, T_hat, 'k', 'linewidth', 1.5);

% Ideal one
V_hat = 0.1 : 0.01 : 3.0;
T_hat = 0.5 .* (V_hat .^ 2 + 1 ./ V_hat .^ 2);
hold on
plot(V_hat, T_hat, 'r');
title("T_h vs V_h");
xlabel("V_h");
ylabel("T_h");
legend("Real one", "Ideal one");



    
    
    
    
    
    
    