clc; clear all;
%input variables
l1 = input('Enter the link 1 length  [in this case 1]');
l2 = input('Enter the link 2 length  [in this case 1]');
lc1 = l1/2;
lc2 = l2/2;
m1 = input('Enter the mass of link 1 [in this case 1]');
m2 = input('Enter the mass of link 2 [in this case 1]');
i1 = 1/12*(m1*l1*l1);
i2 = 1/12*(m2*l2*l2);
g = 10;
syms QQ1 QQ2 QQd1 QQd2 QQdd1 QQdd2 t
ti = input('Enter the initial time [ in  this case 0]');
tf = input('Enter the final time   [ in this case  10');
disp('Please be patient, processing is going on')
%equations for fitting in cubic equation
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
% coefficient matrices
A = (inv(time))*Q;
B = (inv(time))*R;

Q1 = A(1,1) + A(2,1)*t + A(3,1)*(t^2) + A(4,1)*(t^3);
Qd1 = A(2,1) + 2*A(3,1)*t + 3*A(4,1)*(t^2);
Qdd1 = 2*A(3,1) + 6*A(4,1)*t;
Q2 = B(1,1) + B(2,1)*t + B(3,1)*(t^2) + B(4,1)*(t^3);
Qd2 = B(2,1) + 2*B(3,1)*t + 3*B(4,1)*(t^2);
Qdd2 = 2*B(3,1) + 6*B(4,1)*t;
%Calculating for different time period
i = 1;
for t = 0:0.0203:10
    QQ1(i) = A(1,1) + A(2,1)*t + A(3,1)*(t^2) + A(4,1)*(t^3);
    QQd1(i) = A(2,1) + 2*A(3,1)*t + 3*A(4,1)*(t^2);
    QQ2(i) = B(1,1) + B(2,1)*t + B(3,1)*(t^2) + B(4,1)*(t^3);
    QQd2(i) = B(2,1) + 2*B(3,1)*t + 3*B(4,1)*(t^2);
    QQdd1(i) = 2*A(3,1) + 6*A(4,1)*t;
    QQdd2(i) = 2*B(3,1) + 6*B(4,1)*t;  
    T1(i) = (49*cos(QQ1(i) + QQ2(i)))/10 + (147*cos(QQ1(i)))/10 + QQdd1(i)*(cos(QQ2(i)) + 5/3) + QQdd2(i)*(cos(QQ2(i))/2 + 1/3) - QQd2(i)*((QQd1(i)*sin(QQ2(i)))/2 + (QQd2(i)*sin(QQ2(i)))/2) - (QQd1(i)*QQd2(i)*sin(QQ2(i)))/2;
    T2(i) = (sin(QQ2(i))*QQd1(i)^2)/2 + QQdd2(i)/3 + (49*cos(QQ1(i) + QQ2(i)))/10 + QQdd1(i)*(cos(QQ2(i))/2 + 1/3);
    i = i+1;
end
%plotting joint angles and velocities
t = 0 : 0.0203 : 10;
figure(4);
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
figure(3);
plot(t,T1,'b');
hold on
plot(t,T2,'r');
legend('T1','T2');
xlabel('time');
ylabel('Torques Value');
%animation
p = [0 0];
figure(5);
for i = 1 : 1 : 493
    x = l1*cos(QQ1(i)) + l2*cos(QQ1(i)+QQ2(i));
    y = l1*sin(QQ1(i)) + l2*sin(QQ1(i)+QQ2(i));
    plot(0,0,'r.');
    plot(x,y,'r.');
    link1 = line([p(1) l1 * cos(QQ1(i)) ],[p(2) l1 * sin(QQ1(i))],'LineWidth',2);
    link2 = line([l1 * cos(QQ1(i)) x],[l1 * sin(QQ1(i)) y],'LineWidth',4);
    hold on
    pause(0.05)
    delete(link1)
    delete(link2)
    axis([-2 2 -2 2]);
    hold on
end 
