function controlterms = control(t,q)
%inputs
l1 = 1;                                               l2 = 1;
lc1 = l1/2;                                           lc2 = l2/2;
m1 = 1;                                               m2 = 1;
i1 = 1/12*(m1*l1*l1);                                 i2 = 1/12*(m2*l2*l2);
g = 9.8; r1 = 1/100;                                  r2 = r1; 
% syms QQ1 QQ2 QQd1 QQd2 QQdd1 QQdd2 t
ti = 0;                                               tf = 2;
%equations for fitting in cubic equation
time(1,1) = 1;                time(2,1) = 0;                     time(3,1) = 1;                     time(4,1) = 0;
time(1,2) = ti;               time(2,2) = 1;                     time(3,2) = tf;                    time(4,2) = 1;
time(1,3) = ti^2;             time(2,3) = 2*ti;                  time(3,3) = tf^2;                  time(4,3) = 2*tf;
time(1,4) = ti^3;             time(2,4) = 3*(ti^2);              time(3,4) = tf^3;                  time(4,4) = 3*(tf^2);
Q(1,1) = 0;                   Q(2,1) = 0;                        Q(3,1) = pi/6;                     Q(4,1) = 0;
R(1,1) = 0;                   R(2,1) = 0;                        R(3,1) = pi/3;                     R(4,1) = 0;
A = (inv(time))*Q;            B = (inv(time))*R;
QQ1= A(1,1) + A(2,1)*t + A(3,1)*(t^2) + A(4,1)*(t^3);
QQd1= A(2,1) + 2*A(3,1)*t + 3*A(4,1)*(t^2);
QQ2= B(1,1) + B(2,1)*t + B(3,1)*(t^2) + B(4,1)*(t^3);
QQd2= B(2,1) + 2*B(3,1)*t + 3*B(4,1)*(t^2);
QQdd1= 2*A(3,1) + 6*A(4,1)*t;
QQdd2= 2*B(3,1) + 6*B(4,1)*t;  
Jm1 = 0.4*(10^-4);                                   Jm2 = Jm1;
Km1 = 2.32*(10^-2);                                  Km2 = Km1;
Bm1 = 4.77*(10^-5);                                  Bm2 = Bm1;
R1 = 0.365;                                          R2 = R1;
Kb1 = 0.0232;                                        Kb2 = Kb1;
r1 = 1/100;                                          r2 = r1;
w1 = 4;                                              w2 = w1;
Geta1 = 1;                                           Geta2 = Geta1;
K1 = Km1/R1;                                         K2 = Km2/R2;
B1 = Bm1 +(Kb1*Km1/R1);                              B2 = Bm2 +(Kb2*Km2/R2);
J1 = (Jm1/(r1)^2);                                   J2 = Jm2/(r2)^2;
J = diag([J1 J2]);
BB = diag([B1 B2]);
d11 = m1*lc1^2 + m2*(l1^2+lc2^2+2*l1*lc2*cos(q(3)))+i1+i2;
d12 = m2*(lc2^2 + l1*lc2*cos(q(3)))+i2;
d21 = d12;
d22 = m2*lc2^2 + i2;
d = [d11 d12;d21 d22];
h = -m2*l1*lc2*sin(q(3));
c = [h*q(4) h*(q(2)+q(4));-h*q(2) 0];
kp = 200*eye(2);
kd = 10*eye(2);
Qt = [(QQ1 - q(1));(QQ2 - q(3))];
Qdot_matrix = [q(2); q(4)];
Qddot_matrix = inv(d+J)*[kp*Qt-(c+BB+kd)*Qdot_matrix];
controlterms(1,1) = q(2);
controlterms(2,1) = Qddot_matrix(1);
controlterms(3,1) = q(4);
controlterms(4,1) = Qddot_matrix(2);
end