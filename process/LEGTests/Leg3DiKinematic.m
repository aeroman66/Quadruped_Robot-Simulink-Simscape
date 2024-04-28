%% 给自己埋坑了啊，事实上仿真里的坐标系朝向并不重要，在算逆运动学时候坐标系朝向最好保持一致，这才是真正的决定因素
%% 要先得出足端正运动学方程的表达式
syms t1 t2 t3 l1 l2 l3;
% 定义足段点位置 P
P = [0;-l3;0];

% 建立三个关节之间的变换矩阵
T_01 = [cos(t1) -sin(t1) 0 0;
        sin(t1) cos(t1) 0 0;
        0 0 1 0;
        0 0 0 1];
T_12 = [1 0 0 l1;
        0 cos(t2) -sin(t2) 0;
        0 sin(t2) cos(t2) 0;
        0 0 0 1];
T_23 = [1 0 0 0;
        0 cos(t3) -sin(t3) -l2;
        0 sin(t3) cos(t3) 0;
        0 0 0 1];

% 计算足段点在基坐标系中的位置
T_03 = T_01 * T_12 * T_23;
P_t = [P;1];
P_ans = T_03 * P_t;
P_ans = simplify(P_ans(1:3,:));
% size(P_ans)

%% 进行逆运动学解算
syms x y z L;
% 定义足段在基坐标系中的三维空间坐标
P = [x;y;z];
L = sqrt(x^2 + y^2 - l1^2);
% x = P_ans(1);
% y = P_ans(2);
% z = P_ans(3);

% 先求解髋关节角度 th1
% 我们知道足端在髋关节坐标系中的坐标应该是 [l1;-L]，根据手算结果
t1 = atan2((y * l1 + x * L),(x * l1 - y * L));

% 求解 th3
t3 = pi - acos((l2^2 + l3^2 - (x^2 + y^2 + z^2 - l1^2))/(2*l2*l3));

% 求解 th2
syms r
eq = z + l3*(sin(t3)*((l3*cos(t1)*r*sin(t3) + l1*sin(t1) - y)/(l2*cos(t1)+l3*cos(t1)*cos(t3))) + cos(t3)*r) + l2*r;
t2_t = solve(eq,r);
t2 = asin(t2_t);

%% 检验合理性
x = 0.2;
y = -0.8;
z = 0;
l1 = 0.2;
l2 = 0.8;
l3 = 0.8;

t1 = eval(t1)
t2 = eval(t2_t)
t3 = eval(t3)
% 目前带的几个特殊点都是对的，但是估计还有符号问题，以及 t1 无缘无故多了 pi