function controlterms = controltorqueterms(t,q)
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
%Desired trajectory
QQ1= A(1,1) + A(2,1)*t + A(3,1)*(t^2) + A(4,1)*(t^3);
QQd1= A(2,1) + 2*A(3,1)*t + 3*A(4,1)*(t^2);
QQ2= B(1,1) + B(2,1)*t + B(3,1)*(t^2) + B(4,1)*(t^3);
QQd2= B(2,1) + 2*B(3,1)*t + 3*B(4,1)*(t^2);
QQdd1= 2*A(3,1) + 6*A(4,1)*t;
QQdd2= 2*B(3,1) + 6*B(4,1)*t;  
k11 = 100; k12 = 100; k01 = 25; k02 = 25;
controlterms(1,1) = q(2);
controlterms(2,1) = QQdd1 + k11*(QQd1 - q(2)) + k01*(QQ1 - q(1));
controlterms(3,1) = q(4);
controlterms(4,1) = QQdd2 + k12*(QQd2 - q(4)) + k02*(QQ2 - q(3));
end