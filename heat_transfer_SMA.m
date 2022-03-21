function [T] = heat_transfer_SMA(i)
R = 50.8; %resistance/length
h0 = 120; %coefficient of T^0
h2 = 0.0001; %coefficient of T^2
T0 = 290; %ambient temperature
c_p = 200*4.187; %specific heat capacity
A = 4.712*(10^(-4)); %area of wire
m = 1.14*(10^(-4)); % mass/length
h = h0+h2*(T(t))^2;
tspan = [0 1];
y0 = 290;
[t,T] = ode45(@(t,T) odefun(t,T), tspan, y0);
% 64/50.8-(120+0.0001*T^2)*(T-290)/(m*c_p);
plot(t,T);
function dTdt = odefun(t,T)
dTdt = (i^2*50.8-(120+0.0001*T^2)*(T-290))/0.0953;
end
end