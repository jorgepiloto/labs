function [T_hat,V_hat,T_b,V_b] = From_D_2_ND(T,V,p,h,W)
%% INPUTS
% T      --> Thrust                 [N]
% V      --> Velocity               [m/s]
% p      --> Aircraft parameters    (see Parameters.m)
% h      --> Height                 [m]
% W      --> Weight                 [N]

%% OUTPUTS
% T_hat  --> Dimensionless thrust   [-]
% V_hat  --> Dimensionless velocity [-]
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
T_hat = T./T_b;
V_hat = V./V_b;

end