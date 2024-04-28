% 定义 P 点在末端连杆坐标系中的位置
syms l2
P = [l2;0];
P_2 = [P;1];

% 给出两个变换矩阵
syms th1 th2 l1
T_01 = [cos(th1) -sin(th1) 0;
        sin(th1) cos(th1) 0;
        0 0 1];
T_12 = [cos(th2) -sin(th2) l1;
        sin(th2) cos(th2) 0;
        0 0 1];

% 根据变换运算进行总运算
T_02 = T_01 * T_12;

% 求解出 P 点在基坐标系中的位置
P_t = T_02 * P_2;
P_0 = simplify(P_t(1:2,:))