clear all
close all
 
% maximum stress theory figure 5.16
 
theta1=1:1:90;  % we deal with zero degree separately due to singularity (divided by zero)
theta1=[20,40,60,75,80];
theta=theta1/180*pi; %convert it to radian
 
for i=1:length(theta)   %tension case
    sigma_x1=1/cos(theta(i))^2;  %compared to sigma_LU
    sigma_x2=0.025/sin(theta(i))^2;   % compared to sigma_TU
    sigma_x3=0.1/(sin(theta(i))*cos(theta(i))); %compared to tau_LT 
    x=[sigma_x1,sigma_x2,sigma_x3];
    [sigma_x_t(i),Failure_Mode_tension(i)]=min(x);
end
 
sigma_x_tension=[1,sigma_x_t];
th=[0,theta1];
 
 
for i=1:length(theta)   %compression case
    sigma_x1=1/cos(theta(i))^2;  %compared to sigma_LU
    sigma_x2=0.25/sin(theta(i))^2;   % compared to sigma_TU
    sigma_x3=0.1/(sin(theta(i))*cos(theta(i))); %compared to tau_LT 
    x=[sigma_x1,sigma_x2,sigma_x3];
    [sigma_x_c(i),Failure_Mode_compression(i)]=min(x);
end
 
sigma_x_compression=[1,sigma_x_c];
 
plot(th,sigma_x_tension,'k-',th,sigma_x_compression,'k--','linewidth',2);
h=gca;
set(h,'fontsize',20);
xlabel('\theta [Deg]')
ylabel('\sigma_{x} /\sigma_{LT}');
legend('Tension','Compression')
grid
axis([0,90,0.02,1.1])
