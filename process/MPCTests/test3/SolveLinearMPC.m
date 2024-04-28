function control = SolveLinearMPC(A_k, B_k, C_k, q, r, lower, upper, x0, refs, N_p)

    % 预测步长是N_p
    % 设状态量个数是Xn
    Xn = length(x0);
    % refs是N_p个参考状态组合成的参考状态合集
    % refs的维度是[N_p*Xn, 1]
   

    %% 获取矩阵尺寸
[m1, n1] = size(A_k);
[n1, n_in] = size(B_k);

%% calculate M
n = m1 + n1;
h(1:m1,:) = eye(m1);
M(1:m1,:) = eye(m1) * A_k;

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
    
    ll = repmat(lower, N_p, 1);  % 创建一个所有元素的值均为 10 的 3×2 矩阵。A = repmat(10,3,2)
    uu = repmat(upper, N_p, 1);
    
    H = 2 * ((THETA.')*Q*THETA + R);
    f = (THETA.')*Q*(M*x0-refs);
    
    [control,~,~,~,~] = quadprog(H, f, [],[],[],[],ll, uu)
end