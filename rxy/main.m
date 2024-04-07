% Big-M method
M = 1000; 

%Input weights and biases
Weights = {
[1.842, -3.016, 0.039; 1.120, -0.045, 0.172; 1.122, -0.169, 0.235],  % Layer 1
[0.215, -0.936, -0.412; 0.267, -0.536, -0.649; -0.191, 0.578, -0.571],  % Layer 2
[-0.555, -0.119, 0.948]  % Layer 3
};

Biases = {
[-0.392; 1.209; 0.301],  % Layer 1
[1.804; -1.293; -1.339],  % Layer 2
[0.065]  % Layer 3
};


% Parameters setting
Z = [0, -1.08, 0];
C = [-2475, 4703, 0];
I = eye(3);
E = ones(3,3);
O = zeros(3,3);
% Ignore the constant in objective function
const = Biases{3};

% Optimization
% Variables: X0, X1, X2, Z1, Z2 [3*1]

% Objective function
f = [-Z, [0,0,0], Weights{3},[0,0,0],[0,0,0]] % -AX0 + 0X1 + W2X2 + 0Z1 + 0Z2

intcon = [[1,2,3],[10,11,12],[13,14,15]]; %MILP problem, input should be integer, and variables z1 and z2 are binary 

A = [C,[0,0,0],[0,0,0],[0,0,0],[0,0,0];
    Weights{1},-I,O,O,O; 
    -Weights{1},I,O,1000*I,O;
    O,I,O,-M*I,O;
    O,Weights{2},-I,O,O; 
    O,-Weights{2},I,O,1000*I;
    O,O,I,O,-M*I]

b = [2475.6;
    -Biases{1}; 
    Biases{1}+M;
    [0;0;0];
    -Biases{2}; 
    Biases{2}+M;
    [0;0;0]]

ub = [[1;1;1]; [inf;inf;inf]; [inf;inf;inf]; [1;1;1]; [1;1;1]] % Upper bound
lb = [[-1;-1;-1]; [0;0;0]; [0;0;0]; [0;0;0]; [0;0;0]] % Lowwer bound

[x_optimal, fval] = intlinprog(f,intcon,A,b,[],[],lb,ub)