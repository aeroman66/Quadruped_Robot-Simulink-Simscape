%% 一种步态的基本量
r = 0.5;
P = 0.5;
% 偏移时间遵循 RR RF LR LF 的顺序定义
legPhase = [0 P/2 P/2 0];
legStatus = [1 1 1 1]; % 1 stance;0 swing

if time <= 6
    legStatus = [1 1 1 1];
elseif mod(time,P) < P/2
    legStatus = [1 0 0 1];
else
    legStatus = [0 1 1 0];
end