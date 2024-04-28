function [fRR1,fRR2,fRR3,fRF1,fRF2,fRF3,fLR1,fLR2,fLR3,fLF1,fLF2,fLF3] = SolveTipForces(ddp,m)
g = [0;-10;0];

S = [1 0 0;
     0 1 0;
     0 0 1];
W = diag(ones(1,12));

A = [eye(3),eye(3),eye(3),eye(3)]
b = m * (ddp + g);

res = quadprog(A'*S*A + W,-b'*S*A);
fRR1 = res(1);
fRR2 = res(2);
fRR3 = res(3);
fRF1 = res(4);
fRF2 = res(5);
fRF3 = res(6);
fLR1 = res(7);
fLR2 = res(8);
fLR3 = res(9);
fLF1 = res(10);
fLF2 = res(11);
fLF3 = res(12);