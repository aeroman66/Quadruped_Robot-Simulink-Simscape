%% 试图模拟一条轨迹途中三个关节的位置
% 先把逆运动学方程搞出来
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

% 先求解髋关节角度 th1
t1 = atan2((y * l1 + x * L),(x * l1 - y * L));

% 求解 th3
t3 = pi - acos((l2^2 + l3^2 - (x^2 + y^2 + z^2 - l1^2))/(2*l2*l3));

% 求解 th2
syms r
eq = z + l3*(sin(t3)*((l3*cos(t1)*r*sin(t3) + l1*sin(t1) - y)/(l2*cos(t1)+l3*cos(t1)*cos(t3))) + cos(t3)*r) + l2*r;
t2_t = solve(eq,r);
t2 = asin(t2_t);

l1 = 0.2;
l2 = 1.2;
l3 = 1.2;

%% 定义一条轨迹
X = linspace(0,3*pi/4,100);
x = linspace(0.2,0.3,100);
y = sin(X)-2.4;
z = linspace(0,1,100);


% 绘制轨迹示意图
subplot(1,2,1);
plot3(x,z,y)
title('轨迹示意图')
axis([0.1,0.4,-0.2,1.2,-2.5,-1])
xlabel('x')
ylabel('y')
zlabel('z')
grid on

% 求出途中关节位置
T1 = eval(t1);
T2 = eval(t2);
T3 = eval(t3);

% 绘制关节位置图形
subplot(1,2,2);
plot(X,T1,X,T2,X,T3)
title('关节角度示意图')
legend('髋关节','大腿关节','小腿关节')
grid on

