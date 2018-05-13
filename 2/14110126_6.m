l1 = input('Enter the link 1 length');
l2 = input('Enter the link 2 length');
l3 = input('Enter the link 3 length');
disp('Enter angles in degress')
theta1 = input('Enter the joint angle ');
theta2 = input('Enter the joint angle ');
theta3 = input('Enter the joint angle ');
fx = input('Force component in x direction');
fy = input('Force componenet in y direction');
m = input('Moment on body');

F(1,1) = -l1*sind(theta1) -(l2*sind(theta1+theta2))-(l3*sind(theta1+theta2+theta3));
F(1,2) = l1*cosd(theta1)+(l2*cosd(theta1+theta2))+(l3*cosd(theta1+theta2+theta3));
F(2,1) =  -(l2*sind(theta1+theta2))-(l3*sind(theta1+theta2+theta3));
F(3,1) = -(l3*sind(theta1+theta2+theta3));
F(3,2) = (l3*cosd(theta1+theta2+theta3));
F(2,2) = (l2*cosd(theta1+theta2))+(l3*cosd(theta1+theta2+theta3));
F(1,3)=0;
F(1,4)=0;
F(1,5)=0;
F(1,6)=1;
F(2,3)=0;
F(2,4)=0;
F(2,5)=0;
F(2,6)=1;
F(3,3)=0;
F(3,4)=0;
F(3,5)=0;
F(3,6)=1;

f = zeros(6,1);
f(1,1)=fx;
f(2,1)=fy;
f(6,1)=m;
disp('Relation matrix')
disp(F)
T = F*f;
disp('Joint torques')
disp(T)