function forwardterms = forward(t,q)
T1 = 0;T2 = 0;
forwardterms(1,1) = q(2);
forwardterms(2,1) = - (12*(T1 - (49*cos(q(1) + q(3)))/10 - (147*cos(q(1)))/10 + q(4)*((q(2)*sin(q(3)))/2 + (q(4)*sin(q(3)))/2) + (q(2)*q(4)*sin(q(3)))/2))/(9*cos(q(3))^2 - 16) - (6*(3*cos(q(3)) + 2)*((sin(q(3))*q(2)^2)/2 - T2 + (49*cos(q(1) + q(3)))/10))/(9*cos(q(3))^2 - 16);
forwardterms(3,1) = q(4);
forwardterms(4,1) = (12*(3*cos(q(3)) + 5)*((sin(q(3))*q(2)^2)/2 - T2 + (49*cos(q(1) + q(3)))/10))/(9*cos(q(3))^2 - 16) + (6*(3*cos(q(3)) + 2)*(T1 - (49*cos(q(1) + q(3)))/10 - (147*cos(q(1)))/10 + q(4)*((q(2)*sin(q(3)))/2 + (q(4)*sin(q(3)))/2) + (q(2)*q(4)*sin(q(3)))/2))/(9*cos(q(3))^2 - 16);
end