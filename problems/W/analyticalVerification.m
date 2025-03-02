% define variables
k1 = 173; k2 = 148; k3 = 237;
T4 = 300;

L1 = 2e-3;
L2 = 10e-3;
L3 = 1000e-3;

% create coefficient matrix 
A = [0 1 -1; 0 k2/L2 -(k2/L2 + k3/L3); 1 -1 0]

% create RHS
b = [37.15*L2*k1/k2; -k3/L3*T4; 37.15*L1]

% solve the system
ans = linsolve(A,b);

% print results
printf("T1 = %f.2\n", ans(1))
printf("T2 = %f.2\n", ans(2))
printf("T3 = %f.2\n", ans(3))