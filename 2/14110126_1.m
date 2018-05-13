l = zeros(3,1); %link lengths
theta = zeros(3,1);%joint angles
%taking inputs of link lengths
i = 1;
while(i<4)
    disp('Enter the length of')
    disp(i)
    disp('  th link length')
    l(i,1) =input('  ');
    i=i+1;
end
%taking inputs of joint angles
j = 1;
while(j<4)
    disp('Enter the angle of')
    disp(j)
    disp('  th link in degrees')
    theta(j,1) =input(' ');
    j=j+1;
end

p = zeros(3,1);%matrix to store points px, py and phi
p(1,1) = (l(1,1)*cosd(theta(1,1))) + (l(2,1)*cosd(theta(1,1)+theta(2,1)) + (l(3,1)*cosd(theta(1,1)+theta(2,1)+theta(3,1))));
p(2,1) = (l(1,1)*sind(theta(1,1))) + (l(2,1)*sind(theta(1,1)+theta(2,1)) + (l(3,1)*sind(theta(1,1)+theta(2,1)+theta(3,1))));
p(3,1) = theta(1,1) + theta(2,1) +theta(3,1);

%converting orientation angle to 0 to 360 degrees
if(p(3,1)>=360)
    p(3,1) = mod(p(3,1),360);
end
disp('The position px is')
disp(p(1,1))
disp('The position py is')
disp(p(2,1))
disp('The orientation phi is')
disp(p(3,1))