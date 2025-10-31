%% ================================================================
% MAE 471 Project 2 - Failure Criteria for Composite Lamina
% Corrected with True Stress and Strain Transformation Equations
% ================================================================
clear; close all; clc;

%% --- Material Properties ---
sigma_LU = 1.0;    % Longitudinal tensile
sigma_LC = 1.0;    % Longitudinal compressive
sigma_TU = 0.025;  % Transverse tensile
sigma_TC = 0.25;   % Transverse compressive
tau_LT   = 0.1;    % Shear

E_L  = 20e6;
E_T  = 1e6;
G_LT = 0.7e6;
nu_LT = 0.25;                     % Poisson's ratio
nu_TL = nu_LT * (E_T / E_L);      % Reciprocal Poisson's ratio

% Strain limits
eps_LU   = sigma_LU / E_L;
eps_LC   = sigma_LC / E_L;
eps_TU   = sigma_TU / E_T;
eps_TC   = sigma_TC / E_T;
gamma_LTU = tau_LT / G_LT;

%% --- Angles ---
theta_deg = [20 40 60 75 80];
theta = deg2rad(theta_deg);

modeNames = {'Longitudinal','Transverse','Shear'};

%% ================================================================
%  MAXIMUM STRESS THEORY
% ================================================================
for i = 1:length(theta)
    c = cos(theta(i));
    s = sin(theta(i));

    % === Tension ===
    sigma_x = 1;
    sigmaL = sigma_x * c^2;
    sigmaT = sigma_x * s^2;
    tauLT  = -sigma_x * s * c;

    ratio_L = abs(sigmaL) / sigma_LU;
    ratio_T = abs(sigmaT) / sigma_TU;
    ratio_S = abs(tauLT) / tau_LT;
    [maxRatio, fail_t(i)] = max([ratio_L, ratio_T, ratio_S]);
    sigma_t(i) = 1 / maxRatio;

    % === Compression ===
    sigma_x = -1;
    sigmaL = sigma_x * c^2;
    sigmaT = sigma_x * s^2;
    tauLT  = -sigma_x * s * c;

    ratio_L = abs(sigmaL) / sigma_LC;
    ratio_T = abs(sigmaT) / sigma_TC;
    ratio_S = abs(tauLT) / tau_LT;
    [maxRatio, fail_c(i)] = max([ratio_L, ratio_T, ratio_S]);
    sigma_c(i) = 1 / maxRatio;
end

%% ================================================================
%  MAXIMUM STRAIN THEORY
% ================================================================
for i = 1:length(theta)
    c = cos(theta(i));
    s = sin(theta(i));

    % === Tension ===
    sigma_x = 1;
    epsL = (1/E_L)*(c^2 - nu_LT*s^2)*sigma_x;
    epsT = (1/E_T)*(s^2 - nu_TL*c^2)*sigma_x;
    gammaLT = -2*sigma_x*s*c/G_LT;

    ratio_L = abs(epsL) / eps_LU;
    ratio_T = abs(epsT) / eps_TU;
    ratio_S = abs(gammaLT) / gamma_LTU;
    [maxRatio, failS_t(i)] = max([ratio_L, ratio_T, ratio_S]);
    strain_t(i) = 1 / maxRatio;

    % === Compression ===
    sigma_x = -1;
    epsL = (1/E_L)*(c^2 - nu_LT*s^2)*sigma_x;
    epsT = (1/E_T)*(s^2 - nu_TL*c^2)*sigma_x;
    gammaLT = -2*sigma_x*s*c/G_LT;

    ratio_L = abs(epsL) / eps_LC;
    ratio_T = abs(epsT) / eps_TC;
    ratio_S = abs(gammaLT) / gamma_LTU;
    [maxRatio, failS_c(i)] = max([ratio_L, ratio_T, ratio_S]);
    strain_c(i) = 1 / maxRatio;
end

%% ================================================================
%  MAXIMUM WORK THEORY
% ================================================================
for i = 1:length(theta)
    c = cos(theta(i)); s = sin(theta(i));

    % === Tension ===
    sigma_x = 1;
    sigmaL = sigma_x * c^2;
    sigmaT = sigma_x * s^2;
    tauLT  = -sigma_x * s * c;

    W1 = 0.5 * sigmaL^2 / E_L;
    W2 = 0.5 * sigmaT^2 / E_T;
    W3 = 0.5 * tauLT^2 / G_LT;

    W1lim = 0.5 * sigma_LU * eps_LU;
    W2lim = 0.5 * sigma_TU * eps_TU;
    W3lim = 0.5 * tau_LT * gamma_LTU;

    ratio_L = W1 / W1lim;
    ratio_T = W2 / W2lim;
    ratio_S = W3 / W3lim;

    [maxRatio, failW_t(i)] = max([ratio_L, ratio_T, ratio_S]);
    work_t(i) = 1 / maxRatio;

    % === Compression ===
    sigma_x = -1;
    sigmaL = sigma_x * c^2;
    sigmaT = sigma_x * s^2;
    tauLT  = -sigma_x * s * c;

    W1 = 0.5 * sigmaL^2 / E_L;
    W2 = 0.5 * sigmaT^2 / E_T;
    W3 = 0.5 * tauLT^2 / G_LT;

    W1lim = 0.5 * sigma_LC * eps_LC;
    W2lim = 0.5 * sigma_TC * eps_TC;
    W3lim = 0.5 * tau_LT * gamma_LTU;

    ratio_L = W1 / W1lim;
    ratio_T = W2 / W2lim;
    ratio_S = W3 / W3lim;

    [maxRatio, failW_c(i)] = max([ratio_L, ratio_T, ratio_S]);
    work_c(i) = 1 / maxRatio;
end

%% ================================================================
%  PLOTS
% ================================================================


figure;
plot(theta_deg,sigma_t,'k-',theta_deg,sigma_c,'k--','LineWidth',2);
title('Maximum Stress Theory'); grid on;
xlabel('\theta [deg]'); ylabel('\sigma_x / \sigma_{LU}');
legend('Tension','Compression','Location','best');

figure;
plot(theta_deg,strain_t,'b-',theta_deg,strain_c,'b--','LineWidth',2);
title('Maximum Strain Theory'); grid on;
xlabel('\theta [deg]'); ylabel('\sigma_x / \sigma_{LU}');
legend('Tension','Compression','Location','best');

figure;
plot(theta_deg,work_t,'r-',theta_deg,work_c,'r--','LineWidth',2);
title('Maximum Work Theory'); grid on;
xlabel('\theta [deg]'); ylabel('\sigma_x / \sigma_{LU}');
legend('Tension','Compression','Location','best');

set(findall(gcf,'-property','FontSize'),'FontSize',13);

%% ================================================================
%  OUTPUT TABLES
% ================================================================
fprintf('\n============================================================\n');
fprintf('Angle |  Stress_T  Mode_T    |  Stress_C  Mode_C\n');
fprintf('============================================================\n');
for i = 1:length(theta)
    fprintf('%3d°  |  %8.4f  %-12s |  %8.4f  %-12s\n', ...
        theta_deg(i), sigma_t(i), modeNames{fail_t(i)}, ...
        sigma_c(i), modeNames{fail_c(i)});
end

fprintf('\n============================================================\n');
fprintf('Angle |  Strain_T  Mode_T    |  Strain_C  Mode_C\n');
fprintf('============================================================\n');
for i = 1:length(theta)
    fprintf('%3d°  |  %8.4f  %-12s |  %8.4f  %-12s\n', ...
        theta_deg(i), strain_t(i), modeNames{failS_t(i)}, ...
        strain_c(i), modeNames{failS_c(i)});
end

fprintf('\n============================================================\n');
fprintf('Angle |  Work_T    Mode_T    |  Work_C    Mode_C\n');
fprintf('============================================================\n');
for i = 1:length(theta)
    fprintf('%3d°  |  %8.4f  %-12s |  %8.4f  %-12s\n', ...
        theta_deg(i), work_t(i), modeNames{failW_t(i)}, ...
        work_c(i), modeNames{failW_c(i)});
end
fprintf('============================================================\n');
