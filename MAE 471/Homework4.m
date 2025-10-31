clc; clf; clear; close all;

% Material properties
EL  = 42;     
ET  = 14;    
GLT = 7;    
nuLT = 0.25;  

EX = @(theta) 1 ./ (cos(theta).^4/EL + sin(theta).^4/ET + 0.25*(1/GLT - 2*nuLT/EL).*sin(2*theta).^2);

EY = @(theta) 1 ./ (sin(theta).^4/EL + cos(theta).^4/ET + 0.25*(1/GLT - 2*nuLT/EL).*sin(2*theta).^2);

nuXY = @(theta) ( (nuLT/EL - 0.25*(1/EL + 2*nuLT/EL + 1/ET - 1/GLT).*sin(2*theta).^2) .* EX(theta) );

GXY = @(theta) 1 ./ ( (cos(theta).^2 .* sin(theta).^2).*(1/EL + 1/ET - 1/GLT) + (cos(theta).^4 + sin(theta).^4)./GLT + (2*nuLT/EL).*cos(theta).^2 .* sin(theta).^2 );

mX = @(theta) sin(2*theta).*(nuLT + EL/ET - EL/(2*GLT) - cos(theta).^2 .*(1 + 2*nuLT + EL/ET - EL/GLT));

mY = @(theta) sin(2.*theta).*(nuLT + EL/ET - EL/(2*GLT) - sin(theta).^2 .*(1 + 2*nuLT + EL/ET - EL/GLT));

angle = linspace(0,pi/2,500);

% Plot
figure(1);
yyaxis left;
plot(angle*180/pi, EX(angle)/EL, 'LineWidth', 2); hold on;
plot(angle*180/pi, GXY(angle)/GLT, 'LineWidth', 2);
plot(angle*180/pi, nuXY(angle), 'LineWidth', 2);
ylabel('Normalized properties')

yyaxis right;
plot(angle*180/pi, mX(angle), 'LineWidth', 2);
plot(angle*180/pi, mY(angle), 'LineWidth', 2);

legend('E_x / E_L','G_{xy} / G_{LT}','\nu_{xy}','m_x','m_y','Location','Best');
xlabel('Fiber orientation (deg)')

grid on;
ylabel('m_x m_y')