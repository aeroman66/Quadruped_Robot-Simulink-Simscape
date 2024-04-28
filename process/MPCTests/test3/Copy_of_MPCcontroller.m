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

% Ts = 0.1;
% A = eye(4)+A*Ts; % 为什么，在做什么。看上去像是在做离散处理
% B = B*Ts;

% 初始状态 [x; dx; theta; dtheta]
x0 = [0;0;10/180;0];
ref = [0;0;0;0];
N = 10;
refs = repmat(ref,N,1); % 用于堆叠矩阵

% 保存数据
xs     = []; % x
thetas = []; % theta
ts     = []; % time
fs     = []; % F

% 初始状态
x = x0;
t = 0;

% Q矩阵,x和theta权重稍大一点
Q = [10 0 0 0
     0 10 0 0
     0 0 1 0
     0 0 0 1];
R = 0.1;
low = -100;
hi = 100;

% 仿真循环
for i = 1:300
    % mpc求解
    z = SolveLinearMPC(A, B, x*0, Q, R, low, hi, x, refs, N);
    u = z(1);
    x = A*x+B*u;
    % 保存数据
    fs = [fs, u];
    thetas = [thetas; x(3)];
    xs = [xs, x(1)];
    ts = [ts; t];
    t = t + Ts;
end
% 绘图
subplot(3,1,1)
plot(ts, thetas);
title('output: theta')
grid minor
subplot(3,1,2)
plot(ts, xs);
title('output: x')
grid minor
subplot(3,1,3)
plot(ts, fs);
title('input: u')
grid minor