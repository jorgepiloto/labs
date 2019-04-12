function p = Parameters
%% INPUS

%% OUTPUTS
% p --> Aircraft parameters

%% MAIN

p = zeros(10,1);

p(1)  = 47.574;                % Wingspan                       [m]
p(2)  = 286.15;                % Surface                        [m^2]
p(3)  = 7.9;                   % Aspect ratio                   [-]
p(4)  = 0.8;                   % Oswald efficiency              [-]
p(5)  = 0.018;                 % Zero-lift drag coefficient     [-]
p(6)  = 444822;                % Maximum thrust at sea level    [N]
p(7)  = 0.000167;              % Specific fuel consumption      [s^-1]
p(8)  = 1.333*10^6;            % Maximum takeoff weight         [N]
p(9)  = 1/(p(4)*pi*p(3));      % Induced drag coefficient       [-]
p(10) = 1/(2*sqrt(p(9)*p(5))); % Maximum aerodynamic efficiency [-]
end