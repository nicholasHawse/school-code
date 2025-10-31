
clf;
close;
clear;
clc;

sigma = 59; %pascals

n = 0.5;

k1 = 2359; %zirconium
dsigmaZr = @(c) (k1^(1/n) .* c).^n + sigma;

k2 = 39.4; %cobalt
dsigmaCo = @(c) (k2^(1/n) .* c).^n + sigma;

dsigmaZrCo = @(c) (k1^(1/n) .* c + k2^(1/n) * 0.001).^n + sigma;

dsigmaCoZr = @(c) (k2^(1/n) .* c + k1^(1/n) * 0.001).^n + sigma;

%fplot(dsigmaZr,[0 0.15],'Marker','o','LineStyle','none','Color','red')
%hold on;
fplot(dsigmaCo,[0 0.15],'Marker','o','LineStyle','none','Color','b')
hold on;
%fplot(dsigmaZrCo,[0 0.15],'Marker','o','LineStyle','none','Color','m')
%hold on;
fplot(dsigmaCoZr,[0 0.15],'Marker','o','LineStyle','none','Color','g')
xlabel('atomic percent')
ylabel('yeild stress MPa')
title('New yeild stress')
axis([0 0.15 0 200])
legend('Zr Only','Co Only','Zr + 1% Co','Co + 1% Zr','Location','northwest')
savefig('MAE378HW5')


