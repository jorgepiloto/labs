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
    title(contour_titles(i));
end
suptitle("Performance on aircraft turning");
    
    
    
    
    
    
    