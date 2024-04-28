function Fx = MPCcontroller(states)

global A B Q R low hi

% 初始状态 [x; dx; theta; dtheta]
x0 = states;
ref = [0;0;0;0];
N = 10;
refs = repmat(ref,N,1); % 用于堆叠矩阵


% 初始状态
x = x0;
t = 0;

% mpc求解
z = SolveLinearMPC(A, B, x*0, Q, R, low, hi, x, refs, N);
Fx = z(1);