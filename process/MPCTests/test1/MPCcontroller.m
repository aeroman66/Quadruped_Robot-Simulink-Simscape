%% 清屏
clear ;
close all;
clc;

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
n = size (A,1);
p = size(B,2);

Ts = 0.1;
A = eye(4)+A*Ts; % 为什么，在做什么。看上去像是在做离散处理
B = B*Ts;

%% 定义权重矩阵
% 定义Q矩阵,n x n 矩阵
Q=[1 0 0 0;0 1 0 0;
    0 0 1 0;0 0 0 1];
% 定义F矩阵，n x n 矩阵
F=[1 0 0 0;0 1 0 0;
    0 0 1 0;0 0 0 1];
% 定义R矩阵，p x p 矩阵
R=[1];

%% 定义step数量k
% 应该是总的控制步数
k_steps=100;

%% 定义状态和输入矩阵
% 定义矩阵 X_K， n x k 矩 阵
X_K = zeros(n,k_steps);
% 初始状态变量值， n x 1 向量
X_K(:,1) =[0;20/180;0;0];

% 定义输入矩阵 U_K， p x k 矩阵
U_K=zeros(p,k_steps);

%% 定义预测区间K
N=7;

%% Call MPC_Matrices 函数 求得 E,H矩阵 
[E,H]=Matrices(A,B,Q,R,F,N);

%% 计算每一步的状态变量的值
for k = 1 : k_steps
    % 求得U_K(:,k)
    U_K(:,k) = Prediction(X_K(:,k),E,H,N,p);
    % 计算第k+1步时状态变量的值
    X_K(:,k+1)=(A*X_K(:,k)+B*U_K(:,k));
end
 
%% 绘制状态变量和输入的变化
subplot  (3, 1, 1);
plot (X_K(1,:));
legend('x')

subplot  (3, 1, 2);
plot (X_K(2,:));
legend('q')

subplot (3, 1, 3);
hold;
for i =1 : size (U_K,1)
plot (U_K(i,:));
end
legend("u1")
