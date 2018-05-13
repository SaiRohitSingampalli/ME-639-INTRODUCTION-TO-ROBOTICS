clc;
clear all;
l1 = input('Enter the l1 link length');
l2 = input('Enter the l2 link length');
l3 = input('Enter the l3 link length');
w(1,1) = input('Enter the angular velocity of first joint in deg/sec');
w(2,1) = input('Enter the angular velocity of second joint in deg/sec');
w(3,1) = input('Enter the angular velocity of third joint in deg/sec');


theta1 = input('Enter the angle 1 in degrees');
theta2 = input('Enter the angle 2 in degrees');
theta3 = input('Enter the angle 3 in degrees');

J=zeros(3,3);
J(1,1) = -((l1*sind(theta1))+(l2*sind(theta1+theta2)+(l3*sind(theta1+theta2+theta3))));
J(2,1) = ((l1*cosd(theta1))+(l2*cosd(theta1+theta2)+(l3*cosd(theta1+theta2+theta3))));
J(3,1) = 1;
J(3,2)= 1;
J(3,3) = 1;
J(1,2) = -((l2*sind(theta1+theta2))+(l3*sind(theta1+theta2+theta3)));
J(1,3) = -l3 * sind(theta1+theta2+theta3);
J(2,3) = l3*cosd(theta1+theta2+theta3);
J(2,2) = ((l2*cosd(theta1+theta2))+(l3*cosd(theta1+theta2+theta3)));

disp(J)
disp('The velocity components of end effector');
disp(J*w)


