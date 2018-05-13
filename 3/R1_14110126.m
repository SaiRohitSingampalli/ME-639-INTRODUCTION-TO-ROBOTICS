clc; clear all;
%input variables
l1 = input('Enter the link 1 length  [in this case 1]');
l2 = input('Enter the link 2 length  [in this case 1]');
lc1 = l1/2;
lc2 = l2/2;
m1 = input('Enter the mass of link 1 [in this case 1]');
m2 = input('Enter the mass of link 2 [in this case 1]');
syms q1 q2 qd1 qd2 T1 T2
cas = input('Enter the 1 - for Torques to be equal to 0 \n or 2 - for Torques to be equal to sin(t) \n and 3 - for IC [0 0 0 0]');
i1 = 1/12*(m1*l1*l1);
i2 = 1/12*(m2*l2*l2);
g = 9.8;
%equations of motion developed
d11 = (m1*(lc1)^2) + (m2*(l1^2 + lc2^2 + 2*l1*lc2*cos(q2) )) + i1 + i2; 
d12 = (m2*(lc2^2 + l1*lc2*cos(q2)))+ i2;
d21 = (m2*(lc2^2 + l1*lc2*cos(q2)))+ i2;
d22 = m2*(lc2^2)+ i2;


h = -m2 * l1 * lc2 * sin(q2);
c111 = 0;
c121 = h;
c221 = h;
c112 = -h;
c122 = 0;
c222 = 0;


phi1 = (((m1*lc1) + (m2*l1))*g*cos(q1)) + (m2*lc2*g*cos(q1+q2));
phi2 = m2*lc2*g*cos(q1+q2);


p = [0 0];
% spanning using ode45
if(cas==1)
    disp('case 1 is executed')
    [t,q] = ode45('forward',[0 10],[pi/4 0 pi/4 0]);
    za = 493;
elseif(cas==2)
    disp('case 2 is executed')
    [t,q] = ode45('forward2',[0 10],[pi/4 0 pi/4 0]);
    za = 525;
else
    disp('case 3 is executed')
    [t,q] = ode45('forward2',[0 10],[0 0 0 0]);
    za = 505;
end
% animation
for i = 1 : 1 : 493
    x = l1*cos(q(i,1)) + l2*cos(q(i,1)+q(i,3));
    y = l1*sin(q(i,1)) + l2*sin(q(i,1)+q(i,3));
    plot(0,0,'r.');
    link1 = line([p(1) l1 * cos(q(i,1)) ],[p(2) l1 * sin(q(i,1))],'LineWidth',2);
    link2 = line([l1 * cos(q(i,1)) x],[l1 * sin(q(i,1)) y],'LineWidth',4);
    hold on
    pause(0.05)
    delete(link1)
    delete(link2)
    axis([-2 2 -2 2]);
    hold on
end 
%KE, PE and Energy plots
for i = 1:1:za
    K(i) = q(i,4)*((q(i,4)*(cos(q(i,1) + q(i,3))^2/4 + sin(q(i,1) + q(i,3))^2/4))/2 + (q(i,2)*((cos(q(i,1) + q(i,3))*(cos(q(i,1) + q(i,3))/2 + cos(q(i,1))))/2 + (sin(q(i,1) + q(i,3))*(sin(q(i,1) + q(i,3))/2 + sin(q(i,1))))/2))/2) + q(i,2)*((q(i,2)*(cos(q(i,1))^2/4 + sin(q(i,1))^2/4 + (cos(q(i,1) + q(i,3))/2 + cos(q(i,1)))^2 + (sin(q(i,1) + q(i,3))/2 + sin(q(i,1)))^2))/2 + (q(i,4)*((cos(q(i,1) + q(i,3))*(cos(q(i,1) + q(i,3))/2 + cos(q(i,1))))/2 + (sin(q(i,1) + q(i,3))*(sin(q(i,1) + q(i,3))/2 + sin(q(i,1))))/2))/2) + q(i,2)*(q(i,2)/12 + q(i,4)/24) + q(i,4)*(q(i,2)/24 + q(i,4)/24);
    V(i) = (m1*lc1 + m2*l1)*g*sin(q(i,1)) + m2*lc2*g*sin(q(i,1)+q(i,3));
    P(i) = K(i) + V(i);
    PQ1(i) = q(i,1);
    PQ2(i)= q(i,2);
    PQ3(i) = q(i,3);
    PQ4(i) =  q(i,4);
end

figure(2);
plot(t,K,'b');
hold on 
plot(t,V,'r');
hold on
plot(t,P,'g');
legend('Kinetic Energy','Potential Energy','Total Energy');
xlabel('time');
ylabel('Energy');
figure(3);
plot(t,PQ1,'b');
hold on
plot(t,PQ2,'r');
hold on
plot(t,PQ3,'y');
hold on
plot(t,PQ4,'g');
legend('q1','qd1','q2','qd2');
xlabel('time');
ylabel('q values');