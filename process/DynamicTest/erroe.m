Q = [0.5 2 3 4];
w_des = [0;0;0];
dw_des = [0;0;0];
dw = [0;0;0];
Kpw = [100 0 0;
       0 100 0;
       0 0 100];
Kdw = [30 0 0;
      0 30 0;
      0 0 30];

theta = 2 * acos(Q(1))
Omega = (Q(2:4))'/sin(theta/2)

ddw = Kpw * (w_des - theta * Omega) + Kdw * (dw_des - dw)