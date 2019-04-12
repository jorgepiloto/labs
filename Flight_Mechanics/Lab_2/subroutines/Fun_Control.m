function xc = Fun_Control(flag,u,p,inp)
%% INPUTS
% flag  --> Flag for the type of manoeuvre
%       --> 0 Cruise
%       --> 1 Vertical with constant elevation angle
%       --> 2 Vertical with constant thrust level
%       --> 3 Turning
% u     --> State vector
% p     --> Aircraft parameters (see Parameters.m)
%% OUTPUTS
% xc    --> Control vector (thrust level or elevation angle)
%% MAIN
S = p(2);
CD0 = p(5);
TmaxSL = p(6);
k = p(9);

V = u(1);
h = u(3);
W = u(4);

rho = ISA(h);
rho = rho';
rhoSL = ISA(0);

if flag==0
    TL = 1/2*rho.*V.^2*S.*(CD0+k*(W./(1/2*rho.*V.^2*S)).^2)./(TmaxSL*(rho./rhoSL).^0.7);
    
    if TL<0 || TL>1
       error('TL out of the range.') 
    end
    
    xc = TL;
    
elseif flag==1
    gamma = inp;
    TL = (1/2*rho.*V.^2*S.*(CD0+k*(W*cos(gamma)./(1/2*rho.*V.^2*S)).^2)+W*sin(gamma))...
              ./(TmaxSL*(rho./rhoSL).^0.7);  
    if TL<0 || TL>1
       error('TL out of the range.')  
    end
    
    xc = TL;      
elseif flag==2

end 

end 