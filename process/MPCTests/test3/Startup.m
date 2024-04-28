%% car-pole initial condition
 x_0 = 0;
 y_0 = 0.15;
 q_0 = 10; %degree

 wheel_damping = 1e-5;
 joint_damping = 1e-5;

global A B Q R low hi
M = 0.5;
m  = 0.2;
b = 0.1;
I = 0.018;
g = 9.8;
L = 0.3;
q = (M+m )*(I+m *L^2)-(m *L)^2;
p = I*(m +M)+M*m *L^2;
A = [0  1  0  0
     0,  -(I+m *L^2)*b/p, m ^2*g*L^2/p, 0
     0  0  0  1
     0,  -m *L*b/p, m *g*L*(m +M)/p, 0];
B = [0;
     (I+m *L^2)/p;
     0;
     m *L/p];

% 暂时没发现用处
C = [1  0  0  0
     0  0  1  0];
D = [0; 0];

sys = ss(A,B,C,D);
sys_d = c2d(sys,0.1);
A = sys_d.a;
B = sys_d.b;

% Q矩阵,x和theta权重稍大一点
Q = [10 0 0 0
     0 10 0 0
     0 0 1 0
     0 0 0 1];
R = 0.1;
low = -100;
hi = 100;