leg = [0.5;0;0;0.5];
r = 0.8;
T = 4;
postpone = 1;
time = 2;
t = mod(time - postpone - T * (leg+1),T);
t <= (r * T)