function [rho, p, Temp, a] = ISA(h)
%{

	The following function returns atmospheric properties:

	Inputs
	------
	h: float
		Height

	Returns
	-------
	Temp: temperature in [k]
	a: speed of sound in [m/s]
	P: pressure in [Pa]
	rho: density in [kg/m^3]
%}

[Temp, a, P, rho] = atmosisa(h);

end
