clc; clear all;
l1 = 1;                                               l2 = 1;
lc1 = l1/2;                                           lc2 = l2/2;
m1 = 1;                                               m2 = 1;
syms t
r1 = 1/100;                                           r2 = r1;
ti = 0;                                               tf = 2;
disp('Please be patient, processing is going on')
%equations for fitting in cubic equation
time(1,1) = 1;                 time(2,1) = 0;                time(3,1) = 1;                   time(4,1) = 0;
time(1,2) = ti;                time(2,2) = 1;                time(3,2) = tf;                  time(4,2) = 1;
time(1,3) = ti^2;              time(2,3) = 2*ti;             time(3,3) = tf^2;                time(4,3) = 2*tf;
time(1,4) = ti^3;              time(2,4) = 3*(ti^2);         time(3,4) = tf^3;                time(4,4) = 3*(tf^2);
Q(1,1) = 0;                    Q(2,1) = 0;                   Q(3,1) = pi/6;                   Q(4,1) = 0;
R(1,1) = 0;                    R(2,1) = 0;                   R(3,1) = pi/3;                   R(4,1) = 0;
A = (inv(time))*Q;             B = (inv(time))*R;
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
kp = [5 0;0 5];
kd = [10 0;0 10];
[t, q] = ode45('control', [0 2], [0;0;0;0]);
[ddd,eee]=size(q);
for i = 1:1:ddd
    
    PQ1(i) = q(i,1);
    PQ2(i)=  q(i,2);
    PQ3(i) = q(i,3);
    PQ4(i) = q(i,4);
end
deltat = 2/(ddd-1);
i = 1;
for t = 0:deltat:2
    QQ1(i) = A(1,1) + A(2,1)*t + A(3,1)*(t^2) + A(4,1)*(t^3);
    QQd1(i) = A(2,1) + 2*A(3,1)*t + 3*A(4,1)*(t^2);
    QQ2(i) = B(1,1) + B(2,1)*t + B(3,1)*(t^2) + B(4,1)*(t^3);
    QQd2(i) = B(2,1) + 2*B(3,1)*t + 3*B(4,1)*(t^2);
    QQdd1(i) = 2*A(3,1) + 6*A(4,1)*t;
    QQdd2(i) = 2*B(3,1) + 6*B(4,1)*t;  
    i = i+1;
end
%plotting joint angles and velocities
t = 0:deltat:2;
figure(1);
plot(t,QQ1,'r');
hold on 
plot(t,QQd1,'b');
hold on
plot(t,QQdd1,'y');
legend('QQ1','QQd1','QQdd1');
xlabel('time');
ylabel('variation of q1, q1d, q1dd');
figure(2);
plot(t,QQ2,'r');
hold on 
plot(t,QQd2,'b');
hold on
plot(t,QQdd2,'y');
legend('QQ2','QQd2','QQdd2');
xlabel('time');
ylabel('variation of q2, q2d, q2dd');
t = 0:deltat:2;
figure(3);
plot(t,PQ1,'b');
hold on
plot(t,QQ1,'r');
legend('Simulated','Desired');
xlabel('time');
ylabel('q1 values');
figure(4);
plot(t,PQ3,'b');
hold on
plot(t,QQ2,'r');
legend('Simulated','Desired');
xlabel('time');
ylabel('q2 values');
figure(5);
plot(t,PQ2,'b');
hold on
plot(t,QQd1,'r');
legend('Simulated','Desired');
xlabel('time');
ylabel('q1 dot values');
figure(6);
plot(t,PQ1,'b');
hold on
plot(t,QQd2,'r');
legend('Simulated','Desired');
xlabel('time');
ylabel('q2 dot  values');
p = [0 0];
figure(7);
for i = 1 : 1 : ddd
    x = l1*cos(PQ1(i)) + l2*cos(PQ1(i)+PQ3(i));
    y = l1*sin(PQ1(i)) + l2*sin(PQ1(i)+PQ3(i));
    plot(0,0,'r.');
    plot(x,y,'r.');
    link1 = line([p(1) l1 * cos(PQ1(i)) ],[p(2) l1 * sin(PQ1(i))],'LineWidth',2);
    link2 = line([l1 * cos(PQ1(i)) x],[l1 * sin(PQ1(i)) y],'LineWidth',4);
    hold on
    pause(0.05)
    delete(link1)
    delete(link2)
    axis([-5 5 -5 5]);
    hold on
end 
figure(8);
plot(t,QQ1-PQ1)
title('Difference in desired and simulated output of q1')
xlabel('time(s)')
ylabel('radian')
figure(9)
plot(t,QQ2-PQ3)
title('Difference in desired and simulated output of q2')
xlabel('time(s)')
ylabel('radian')


