


scf = @(vf) (1-(4/pi.*vf).^5.5 .* 0.95)./( 1 - vf*0.95);

smf = @(vf) (1-(4/pi.*vf).^5.5 * 0.95);

fplot(scf,[0 1])
hold on;
fplot(smf,[0 1])
ylim([-40 5])
xlabel('V_f')
ylabel('\sigma_T_U / \sigma_m_u')
legend('SCF','SFM','Location','best')
grid on;