function T_hat = per_vertical(V_hat, gamma)

% Retreive parameters
global p
Em = p(10); 

T_hat = 1 / 2 .* (V_hat .^ 2 + cos(gamma) .^2 ./ V_hat .^ 2) + Em .* sin(gamma);
end