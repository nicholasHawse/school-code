% how to calculate Q (stiffness) matrix

clear all
close all

Ef=70; % Gpa
Em=1;
Vf=0.5;
muf=0.2;
mum=0.3;
Vm=1-Vf;
EL=Vf*Ef+Vm*Em

ET=1/(Vf/Ef+Vm/Em)

muLT=Vf*muf+Vm*mum;

muTL=muLT/EL*ET            % muLT/EL=muTL/ET

Gf=Ef/(2*(1+muf))
Gm=Em/(2*(1+mum))

GLT=1/(Vf/Gf+Vm/Gm)

Q11=EL/(1-muLT*muTL);

Q12=muLT*ET/(1-muLT*muTL);

Q22=ET/(1-muLT*muTL);

Q66=GLT

Q=[Q11,Q12,0;Q12,Q22,0;0,0,Q66]