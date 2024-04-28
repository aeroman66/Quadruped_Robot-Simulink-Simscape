function [tq1,tq2,tq3]= JacobianTest(fx,fy,fz,t1,t2,t3)
l1 = 0.2;
l2 = 0.8;
l3 = 0.8;
J = [l2*cos(t1)*cos(t2) - l1*sin(t1) - l3*(cos(t1)*sin(t2)*sin(t3) - cos(t1)*cos(t2)*cos(t3)), - l3*(cos(t2)*sin(t1)*sin(t3) + cos(t3)*sin(t1)*sin(t2)) - l2*sin(t1)*sin(t2), -l3*(cos(t2)*sin(t1)*sin(t3) + cos(t3)*sin(t1)*sin(t2));
l1*cos(t1) - l3*(sin(t1)*sin(t2)*sin(t3) - cos(t2)*cos(t3)*sin(t1)) + l2*cos(t2)*sin(t1),   l3*(cos(t1)*cos(t2)*sin(t3) + cos(t1)*cos(t3)*sin(t2)) + l2*cos(t1)*sin(t2),  l3*(cos(t1)*cos(t2)*sin(t3) + cos(t1)*cos(t3)*sin(t2));
                                                                                       0,                                                - l3*cos(t2 + t3) - l2*cos(t2),                                        -l3*cos(t2 + t3)]
tau = -J' * [fx;fy;fz];
tq1 = tau(1)
tq2 = tau(2)
tq3 = tau(3)