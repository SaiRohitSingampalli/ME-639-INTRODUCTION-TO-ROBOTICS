clc;
clear all;
l1 = input('Enter the l1 link length');
l2 = input('Enter the l2 link length');
l3 = input('Enter the l3 link length');

a=1;
for theta1 = 0:1:361
    for theta2= 0:1:361
        for theta3= 0:1:361
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
            
            if(det(J)==0)
                theta(a,1)=theta1;
                theta(a,2)=theta2;
                theta(a,3)=theta3;
                a=a+1;
            end
            
 
            
            
        end
    end
end
disp('The angles for which singularity case satifies are represented by matrix theta');

disp(theta)




