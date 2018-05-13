M = 3;
N = 3;
R = zeros(M,N);

for i=1:M
    for j=1:N
        
        R(i,j)=input('Enter value');
        
    end
end

theta = acos((trace(R)-1)/2);
c = 1/(2*sin(theta));
a = c*(R(3,2)-R(2,3));
b = c*(R(1,3)-R(3,1));
d = c*(R(2,1)-R(1,2));

Vector =[a;b;d];
disp('The angle');
disp(theta);
disp('Fixed axis');
disp(Vector);
