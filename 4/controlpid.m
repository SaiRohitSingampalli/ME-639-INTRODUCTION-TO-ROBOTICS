function controlterms = controlpid(t,q)
%inputs
l1 = 1;                                               l2 = 1;
lc1 = l1/2;                                           lc2 = l2/2;
m1 = 1;                                               m2 = 1;
i1 = 1/12*(m1*l1*l1);                                 i2 = 1/12*(m2*l2*l2);
g = 9.8; r1 = 1/100;                                          r2 = r1; 
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

qqqq1 = [A(4,1) A(3,1) A(2,1) A(1,1)];
cosqqqq1 = @(t) cos(A(4,1)*t.^3 + A(3,1)*t.^2 + A(2,1)*t.^1 + A(1,1)*t.^0);
sinqqqq1 = @(t) sin(A(4,1)*t.^3 + A(3,1)*t.^2 + A(2,1)*t.^1 + A(1,1)*t.^0);
cosqqqq1_avg = integral(cosqqqq1,0,2)/2;
sinqqqq1_avg = integral(sinqqqq1,0,2)/2;

qqqq2 = [B(4,1) B(3,1) B(2,1) B(1,1)];
cosqqqq2 = @(t) cos(B(4,1)*t.^3 + B(3,1)*t.^2 + B(2,1)*t.^1 + B(1,1)*t.^0);
sinqqqq2 = @(t) sin(B(4,1)*t.^3 + B(3,1)*t.^2 + B(2,1)*t.^1 + B(1,1)*t.^0);
cosqqqq2_avg = integral(cosqqqq2,0,2)/2;
sinqqqq2_avg = integral(sinqqqq2,0,2)/2;
%D11avg = avg(cos(r2*q2_des)) + 5/3;
D11 = @(t) cos(r2*(B(4,1)*t.^3 + B(3,1)*t.^2 + B(2,1)*t.^1 + B(1,1)*t.^0));
D11_avg = integral(D11,0,2)/2;
D22 = 1/3;

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
J1 = Jm1 + (r1*r1*(D11_avg + (5/3)));                              
J2 = Jm2 + r2*r2*D22;
Kp1 = (w1*w1*J1)/K1;                                Kp2 = (w2*w2*J2)/K2;
Kd1 = 2*Geta1*w1*J1 - (B1/K1);                      Kd2 = 2*Geta2*w2*J2 - (B2/K2);
Ki1 = 1; Ki2 = 1;



d11 = cos(r2*q(3)) + 5/3;
d12 = cos(r2*q(3))/2 + 1/3;
d21 = d12;
d22 = 1/3;

h = -(sin(r2*q(3)))/2;
c111 = 0;
c121 = h;
c211 = h;
c221 = h;
c112 = -h;
c122 = 0;
c212 = 0;
c222 = 0;


phi1 = (g*cos(r1*q(1) + r2*q(3)))/2 + (3*g*cos(r1*q(1)))/2;
phi2 = (g*cos(r1*q(1) + r2*q(3)))/2;

rsd1 = c121*r1*r2*q(2)*q(4) + c211*r1*q(2)*r2*q(4)+c221*(r2*q(4))^2 + phi1;
rsd2 = c112*(r1*q(2))^2 + phi2;


couple = [J1       r1*r2*d21;
          r1*r2*d21 J2];

V(1) = Kp1*(QQ1 - q(1)) - Kd1*q(2) + Ki1*q(5);
V(2) = Kp2*(QQ2 - q(3)) - Kd2*q(4) + Ki2*q(6);

CoupleRHS(1) = K1*V(1)-r1*rsd1-B1*q(2);
CoupleRHS(2) = K2*V(2)-r2*rsd2-B2*q(4);

QdotMatrix = inv(couple)*[CoupleRHS(1);CoupleRHS(2)];



controlterms(1,1) = q(2);
controlterms(2,1) = (QdotMatrix(1));
controlterms(3,1) = q(4);
controlterms(4,1) = (QdotMatrix(2));
controlterms(5,1) = QQ1 - q(1);
controlterms(6,1) = QQ2 - q(3);

end