%link lengths input
l1 = input('Enter the length 1');
l2 = input('Enter the length 2 ');
l3 = input('Enter the length 3');
%end effecter points and orientation input
px = input('Enter the px value');
py = input('Enter the py value');
phi = input('Enter the phi value in degrees');
%calculating the point intersection of link 2  and link3
x = px - (l3*cosd(phi));
y = py - (l3*sind(phi));

%to calculate theta2 joint angle leading to  get two values and two different
%solutions
theta2(1,1) = acosd(((x^2)+(y^2)-(l1^2)-(l2^2))/(2*l1*l2));
theta2(2,1) = -theta2(1,1);

s2(1,1)=sqrt(1-((cosd(theta2(1,1)))^2));
s2(2,1)=-s2(1,1);

k1 = l1+(l2*cosd(theta2(1,1)));
k2(1,1) = l2 * s2(1,1);
k2(2,1) = l2 * s2(2,1);

con1 = k2(1,1)/k1;
con2 = k2(2,1)/k1;
gama(1,1) =atand(con1) ;
gama(2,1) =atand(con2);


theta1(1,1) = atand(py/px)-gama(1,1);
theta1(2,1) = atand(py/px)-gama(2,1);

theta3(1,1) = phi - theta1(1,1)-theta2(1,1);
theta3(2,1) = phi - theta1(2,1)-theta2(2,1);

disp('The possible solution 1')
disp('theta 1 ')
disp(theta1(1,1))
disp('theta 2')
disp(theta2(1,1))
disp('theta 3')
disp(theta3(1,1))

disp('The possible solution 2')
disp('theta 1')
disp(theta1(2,1))
disp('theta 2')
disp(theta2(2,1))
disp('theta 3')
disp(theta3(2,1))

