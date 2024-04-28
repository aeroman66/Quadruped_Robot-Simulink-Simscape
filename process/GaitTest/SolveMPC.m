function res = SolveMPC(p_des,v_des,w_des,dw_des,p,v,Q,dw,Rsb,m,Ib,PRRx,PRFx,PLRx,PLFx)
% 定义状态空间方程
A = [zeros(3,3),eye(3),zeros(3,3),zeros(3,3),zeros(3,1);
     zeros(3,3),zeros(3,3),zeros(3,3),zeros(3,3),[0;-1;0];
     zeros(3,3),zeros(3,3),zeros(3,3),Rsb,zeros(3,1);
     zeros(3,3),zeros(3,3),zeros(3,3),zeros(3,3),zeros(3,1);
     zeros(1,13)];
B = [zeros(3,3),zeros(3,3),zeros(3,3),zeros(3,3);
     eye(3)/m,eye(3)/m,eye(3)/m,eye(3)/m;
     zeros(3,3),zeros(3,3),zeros(3,3),zeros(3,3);
     (Rsb*Ib*Rsb')*PRRx,(Rsb*Ib*Rsb')*PRFx,(Rsb*Ib*Rsb')*PLRx,(Rsb*Ib*Rsb')*PLFx;
     zeros(1,12)];

C = [eye(12),zeros(12,1)];
D = zeros(12,12);

% 离散化系统
sys = ss(A,B,C,D);
sys_d = c2d(sys,0.1);
A_k = sys_d.a;
B_k = sys_d.b;

% 定义权重矩阵
q = eye(13);
r = eye(12);

% 初始状态
x0 = [p;v;Q;dw];
ref = [p_des;v_des;w_des;dw_des];
N_p = 10;
refs = repmat(ref,N_p,1); % 用于堆叠矩阵

% mpc求解
[m1, nA] = size(A_k);
[m2, n_in] = size(B_k);

%% calculate M
h = zeros(m1*N_p,nA);
M = zeros(m1*N_p,nA);
h(1:m1,:) = eye(m1);
M(1:m1,1:nA) = eye(m1) * A_k;

for kk = 2 : N_p
    h((kk - 1) * m1 + 1 : kk * m1, :) = h((kk - 2) * m1 + 1 : (kk - 1) * m1,:) * A_k;
    M((kk - 1) * m1 + 1 : kk * m1, :) = M((kk - 2) * m1 + 1 : (kk - 1) * m1, :) * A_k;
end

%% Calculate C
% first column of C
v = h * B_k;
THETA = zeros(N_p * m1, N_p * n_in);
THETA(:,1 : n_in) = v;

% Other columns of \Phi
for i = 2 : N_p
    THETA(:,(i-1) * n_in + 1 : i * n_in) = [zeros((i-1) * m1, n_in);v(1:(N_p - i + 1) * m1, 1 : n_in)];
end
    
    % Q,R
    Q = [];
    R = [];
    
    for i = 1:N_p
        Q = blkdiag(Q, q);  % 从三个不同大小的矩阵创建一个分块对角矩阵
        R = blkdiag(R, r);  % 从三个不同大小的矩阵创建一个分块对角矩阵
    end
    
H = 2 * ((THETA.')*Q*THETA + R);
f = (THETA.')*Q*(M*x0-refs);
options = optimoptions('quadprog','Algorithm','active-set');
res = quadprog(H, f, [],[],[],[],[],[],zeros(120,1),options);
res = res(1:12);