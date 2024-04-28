syms t1 t2 t3 l1 l2 l3;
% l1 = 0.2;
% l2 = 1.2;
% l3 = 1.2;
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
T_03 = T_01 * T_12 * T_23
P_t = [P;1];
P_ans = T_03 * P_t;
P_ans = simplify(P_ans(1:3,:));
% size(P_ans)

%% 结果检验
syms x y z;
x = P_ans(1);
y = P_ans(2);
z = P_ans(3);

J = jacobian([x y z],[t1,t2,t3]);
size(J)