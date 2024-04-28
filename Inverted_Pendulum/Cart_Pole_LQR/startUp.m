 clear;

 %% car-pole properties
 global M m l g K_LQR
 M = 0.5;
 m = 0.5;
 l = 0.3;
 g = 9.81;
 wheel_damping = 1e-5;
 joint_damping = 1e-5;

 %% car-pole initial condition
 x_0 = 0;
 y_0 = 0.15;
 q_0 = 10; %degree

 %% Controllers
 LQR = 1;

 if LQR
     K_LQR = cartPoleLQR
 end