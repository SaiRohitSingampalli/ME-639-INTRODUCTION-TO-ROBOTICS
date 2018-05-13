clc;
clear all;
%length inputs
l1 = input('Enter the l1 link length');
l2 = input('Enter the l2 link length');
l3 = input('Enter the l3 link length');
disp('Enter the angle of')%orientation input
disp('orientation phi in degreees')
deg =input(' ');

if(deg > 360)
    deg = mod(deg,360);
end

%theta1= 0:0.1:2*pi;
%theta2= 0:0.1:2*pi;
%theta3= 0:0.1:2*pi;

a=1;
z=1;
for theta1 = 0:5:361
    for theta2= 0:5:361
        for theta3= 0:1:361
            
            p = zeros(3,1);
            p(3,1) = theta1 + theta2 +theta3;
            if(p(3,1)>360)
                 p(3,1) = mod(p(3,1),360);
            end
            if (p(3,1)== deg)
                p(1,1) = (l1*cosd(theta1)) + (l2*cosd(theta1+theta2)) + (l3*cosd(theta1+theta2+theta3));
                p(2,1) = (l1*sind(theta1)) + (l2*sind(theta1+theta2) + (l3*sind(theta1+theta2+theta3)));
                x(a)=p(1,1);
                y(a)=p(2,1);
                a=a+1;
            end
            
            
        end
    end
end

plot(x,y,'.')
