function  [E, H]=Matrices(A,B,Q,R,F,N)
    %% 该函数用以计算预测部分的 F \Phi 矩阵
%% 获取矩阵尺寸
[m1, n1] = size(A);
[n1, n_in] = size(B);

%% calculate M
n = m1 + n1;
h(1:m1,:) = eye(m1);
M(1:m1,:) = eye(m1) * A;

for kk = 2 : N
    h((kk - 1) * m1 + 1 : kk * m1, :) = h((kk - 2) * m1 + 1 : (kk - 1) * m1,:) * A;
    M((kk - 1) * m1 + 1 : kk * m1, :) = M((kk - 2) * m1 + 1 : (kk - 1) * m1, :) * A;
end

%% Calculate C
% first column of C
v = h * B;
C = zeros(N * m1, N * n_in);
C(:,1 : n_in) = v;

% Other columns of \Phi
for i = 2 : N
    C(:,(i-1) * n_in + 1 : i * n_in) = [zeros((i-1) * m1, n_in);v(1:(N - i + 1) * m1, 1 : n_in)];
end
M = [eye(2);M];
C = [zeros(m1,m1*N);C];
    % size(M)
    % size(C)
    % 定义Q_bar和R_bar
    Q_bar = kron(eye(N),Q);
    Q_bar = blkdiag(Q_bar,F);
    R_bar = kron(eye(N),R);
    % 计算G, E, H
    G=M'*Q_bar*M; % G: n x n
    E=C'*Q_bar*M; % E: NP x n
    H=C'*Q_bar*C+R_bar; % NP x NP
end