function ddp = PDControl(p,dp)
p_des = [1;1;1];
dp_des = [0;0;0];

Kp = [1 0 0;
      0 1 0;
      0 0 1];
Kd = [1 0 0;
      0 1 0;
      0 0 1];

ddp = Kp * (p_des - p) + Kd * (dp_des - dp);
