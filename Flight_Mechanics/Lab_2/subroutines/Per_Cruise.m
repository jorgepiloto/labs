function out = Per_Cruise(inp,flag)
%% INPUTS
% inp  --> Dimensionless velocity or thrust
% flag --> Flag indicating if out is thrust or velocity  
%      --> 0 Thrust
%      --> 1 Velocity
%% OUTPUTS


%% MAIN


if flag==0
    V_hat = inp;
    T_hat = 1/2*(V_hat.^2+1./V_hat.^2);
    out = T_hat;
elseif flag==1
    T_hat = inp;
    V_hat_minus = sqrt(T_hat-sqrt(T_hat.^2-1));
    V_hat_plus = sqrt(T_hat+sqrt(T_hat.^2-1));
    out = [V_hat_minus V_hat_plus];
end    
   
end