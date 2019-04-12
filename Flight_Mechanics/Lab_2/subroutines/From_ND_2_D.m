function [T,V,T_b,V_b] = From_ND_2_D(T_hat,V_hat,p,h,W)
%% INPUTS
% T_hat  --> Dimensionless thrust   [-]
% V_hat  --> Dimensionless velocity [-]
% p      --> Aircraft parameters    (see Parameters.m)
% h      --> Height                 [m]
% W      --> Weight                 [N]

%% OUTPUTS
% T      --> Thrust                 [N]
% V      --> Velocity               [m/s]
% T_b    --> Base thrust            [N]
% V_b    --> Base velocity          [m/s]

%% MAIN
[rho,~,~,~] = ISA(h);
rho = rho';
S = p(2);
CD0 = p(5);
k = p(9);


T_b = 2*sqrt(k*CD0).*W;
V_b = sqrt(2*W./(rho*S))*(k/CD0)^(1/4);
T = T_hat.*T_b;
V = V_hat.*V_b;