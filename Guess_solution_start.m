close all; clear all; clc
global theta0 r h kappa sigma l2;
global N; N=101;
global y_guess;

theta0=pi/2;
r=1;
h=25.0;
kappa = 1;
sigma=1.0;
l2=1.0;

L = 1;
solinit = bvpinit(linspace(0,1,101),@mat4init,L);
sol = bvp4c(@mat4ode, @mat4bc, solinit);
fprintf('Value of arc-length L %7.3f.\n',...
            sol.parameters)

%solinit = bvpinit(linspace(0,1,101),@newguess,L);
%sol = bvp4c(@mat4ode, @mat4bc, solinit);

xint = linspace(0,1);
Sxint = deval(sol,xint);

t = linspace(0,1,101);
y_guess = deval(sol,t);

fprintf('Final theta0 %7.3f.\n',...
            theta0)

%plot(xint,Sxint)
plot(sol.y(5,:),sol.y(4,:))
%plot(sol.x,sol.y(2,:))
%axis([0 5 0.4 0.7])
%title('h=20') 
title('\psi = \pi/2')
xlabel('Z')
ylabel('R')
%legend('Psi','Phi','Lambda1','R','Z')
%legend('Z vs R')




function dydx = mat4ode(x,y,L) % equation being solved
global kappa sigma l2;
%sigma=1;
%l2=1;
dydx = [L*y(2)
        L*(    (-l2*cos(y(1)) + y(3)*sin(y(1)))/(kappa*y(4)) + (cos(y(1))/y(4))*(sin(y(1))/y(4) - y(2)))
        L*((kappa/2)*(y(2)*y(2) - (sin(y(1))*sin(y(1)))/(y(4)*y(4))) + sigma)
        L*cos(y(1))
        L*sin(y(1))];
end
%-------------------------------------------
function res = mat4bc(ya,yb,L) % boundary conditions
global theta0 r h;
%global r;
%r=1.0;
%h=2.0;
res = [ya(1) - theta0; yb(1) - pi + theta0; ya(4)-r; yb(4)-r; ya(5); yb(5)-h];
end
%-------------------------------------------
function yinit = mat4init(x) % initial guess function
global theta0 r h;
%theta0=pi/2;
%r=1.0;
%h=2.0;
yinit = [x*x-x+theta0;
         x*x-x+1;
         -x*2+1;
         (2.8-4*r)*x*x-(2.8-4*r)*x+r;
         x];
end
%-------------------------------------------
function v = newguess(q)
global N; 
global y_guess;
 
q = round(q*(N-1));
v = y_guess(:,q+1);
 
end
%...........................................
%..........................................
