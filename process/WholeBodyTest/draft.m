function qs = InvKine(pos,legStrucs)
x = pos(1);
y = pos(2);
z = pos(3);
l1 = legStrucs(1);
l2 = legStrucs(2);
l3 = legStrucs(3);

L = sqrt(x^2 + y^2 - l1^2);

% th1
t1 = atan2((y * l1 + x * L),(x * l1 - y * L));

% 求解 th3
t3 = pi - acos((l2^2 + l3^2 - (x^2 + y^2 + z^2 - l1^2))/(2*l2*l3));

% 求解 th2
eq = z + l3*(sin(t3)*((l3*cos(t1)*sin(t2)*sin(t3) + l1*sin(t1) - y)/(l2*cos(t1)+l3*cos(t1)*cos(t3))) + cos(t3)*sin(t2)) + l2*sin(t2);
t2 = solve(eq,t2);
% t2 = asin(t2_t);

qs = [t1;t2;t3];
end