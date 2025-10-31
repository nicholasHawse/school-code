EL = 81.7;
ET = 9.1;
nuLT = 1.97;
nuTL = 0.22;
GLT = EL/(2+2*nuLT);

Q11 = EL/(1-nuLT*nuTL);
Q12 = nuLT*ET/(1-nuLT*nuTL);
Q22 = ET/(1-nuLT*nuTL);
Q66 = GLT;

Q = [Q11 Q12 0;
     Q12 Q22 0;
     0   0   Q66;]

S = Q ^ (-1)
