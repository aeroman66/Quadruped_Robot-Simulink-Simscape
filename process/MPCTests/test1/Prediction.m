function u_k= Prediction(x_k,E,H,N,p)
    lb = [-10;-10;-10;-10];
    up = [10;10;10;10];
    U_k = zeros(N*p,1); % NP x 1
    U_k = quadprog(H,x_k'*E,[],[],[],[],lb,up);
    u_k = U_k(1:p,1); % 取第一个结果
end 
