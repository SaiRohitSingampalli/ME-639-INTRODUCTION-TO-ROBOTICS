function forwardterms = torquenew(t,q)
ti = 0;
tf = 10;


time(1,1) = 1;
time(2,1) = 0;
time(3,1) = 1;
time(4,1) = 0;
time(1,2) = ti;
time(2,2) = 1;
time(3,2) = tf;
time(4,2) = 1;
time(1,3) = ti^2;
time(2,3) = 2*ti;
time(3,3) = tf^2;
time(4,3) = 2*tf;
time(1,4) = ti^3;
time(2,4) = 3*(ti^2);
time(3,4) = tf^3;
time(4,4) = 3*(tf^2);
Q(1,1) = 0;
Q(2,1) = 0;
Q(3,1) = pi/6;
Q(4,1) = 0;
R(1,1) = 0;
R(2,1) = 0;
R(3,1) = pi/3;
R(4,1) = 0;

A = (inv(time))*Q;
B = (inv(time))*R;
QQ1= A(1,1) + A(2,1)*t + A(3,1)*(t^2) + A(4,1)*(t^3);
QQd1= A(2,1) + 2*A(3,1)*t + 3*A(4,1)*(t^2);
QQ2= B(1,1) + B(2,1)*t + B(3,1)*(t^2) + B(4,1)*(t^3);
QQd2= B(2,1) + 2*B(3,1)*t + 3*B(4,1)*(t^2);
QQdd1= 2*A(3,1) + 6*A(4,1)*t;
QQdd2= 2*B(3,1) + 6*B(4,1)*t;  
T1= (49*cos(QQ1+ QQ2))/10 + (147*cos(QQ1))/10 + QQdd1*(cos(QQ2) + 5/3) + QQdd2*(cos(QQ2)/2 + 1/3) - QQd2*((QQd1*sin(QQ2))/2 + (QQd2*sin(QQ2))/2) - (QQd1*QQd2*sin(QQ2))/2;
%T2 = (sin(QQ2)*QQd1^2)/2 + QQdd2/3 + (49*cos(QQ1 + QQ2))/10 + QQdd1*(cos(QQ2)/2 + 1/3);
 T2 = 0;   

forwardterms(1,1) = q(2);
forwardterms(2,1) = - (12*(T1 - (49*cos(q(1) + q(3)))/10 - (147*cos(q(1)))/10 + q(4)*((q(2)*sin(q(3)))/2 + (q(4)*sin(q(3)))/2) + (q(2)*q(4)*sin(q(3)))/2))/(9*cos(q(3))^2 - 16) - (6*(3*cos(q(3)) + 2)*((sin(q(3))*q(2)^2)/2 - T2 + (49*cos(q(1) + q(3)))/10))/(9*cos(q(3))^2 - 16);
forwardterms(3,1) = q(4);
forwardterms(4,1) = (12*(3*cos(q(3)) + 5)*((sin(q(3))*q(2)^2)/2 - T2 + (49*cos(q(1) + q(3)))/10))/(9*cos(q(3))^2 - 16) + (6*(3*cos(q(3)) + 2)*(T1 - (49*cos(q(1) + q(3)))/10 - (147*cos(q(1)))/10 + q(4)*((q(2)*sin(q(3)))/2 + (q(4)*sin(q(3)))/2) + (q(2)*q(4)*sin(q(3)))/2))/(9*cos(q(3))^2 - 16);
end