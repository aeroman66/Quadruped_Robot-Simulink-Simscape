%% 因为不希望足端发生滑移，所以我们有已经固定的各个 p_{si}
psRR = [0;0;0;1];
psRF = [2.5;0;0;1];
psLR = [0;0;-0.7;1];
psLF = [2.5;0;-0.7;1];

%% 根据我们希望的机体目标状态，我们可以求解出世界坐标系到机体坐标系的齐次变换矩阵
syms x y z alpha beta gamma

% 得出绕各个轴的旋转矩阵
Rz = [cos(alpha) -sin(alpha) 0;
      sin(alpha) cos(alpha) 0;
      0 0 1];
Ry = [cos(beta) 0 sin(beta);
      0 1 0;
      -sin(beta) 0 cos(beta)];
Rx = [1 0 0;
      0 cos(gamma) -sin(gamma);
      0 sin(gamma) cos(gamma)];
% 得出机体坐标系原点在世界坐标系中的坐标
pbRR0 = [-1.25;-1;0.35+0.2];
pd = [x;y;z];

Tsb = [Rz*Ry*Rx -pbRR0+pd;
       zeros(1,3) ones(1,1)];

Tbs = [(Rz*Ry*Rx)' -(Rz*Ry*Rx)'*(-pbRR0+pd);
        zeros(1,3) ones(1,1)];

%% 根据齐次变换矩阵，我们可以求解机体坐标系下的足端位置
pbRR = Tbs * psRR;
pbRF = Tbs * psRF;
pbLR = Tbs * psLR;
pbLF = Tbs * psLF;

% % 测试
% x = 0;
% y = 0;
% z = 0;
% alpha = 0;
% beta = 0;
% gamma = 0;
% eval(pbLF)

%% 再求出单腿坐标系下的足端位置，用单腿逆运动学得到各个关节角度就可以了
plRR = pbRR(1:3,:) - [-1.25;0;0.35];
plRF = pbRF(1:3,:) - [1.25;0;0.35];
plLR = pbLR(1:3,:) - [-1.25;0;-0.35];
plLF = pbLF(1:3,:) - [1.25;0;-0.35];

% x = 0;
% y = 0;
% z = 0;
% alpha = 0;
% beta = 0;
% gamma = 0;
% eval(plRR)