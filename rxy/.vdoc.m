%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
% Big-M method
M = 1000; 

%Input weights and biases
Weights = {
% Layer 1
[1.842, -3.016, 0.039; 1.120, -0.045, 0.172; 1.122, -0.169, 0.235],  
% Layer 2
[0.215, -0.936, -0.412; 0.267, -0.536, -0.649; -0.191, 0.578, -0.571], 
% Layer 3
[-0.555, -0.119, 0.948]  
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
O = zeros(3,3);

% Ignore the constant in objective function temporarily
const = Biases{3};

% Optimization
% Variables: X0, X1, X2, Z1, Z2 [3*1]

% Objective function
f = [-Z, [0,0,0], Weights{3},[0,0,0],[0,0,0]] % -AX0 + 0X1 + W2X2 + 0Z1 + 0Z2

intcon = [[1,2,3],[10,11,12],[13,14,15]]; %MILP problem,
%input should be integer, and variables z1 and z2 are binary 

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

[x_optimal, fval] = intlinprog(f,intcon,A,b,[],[],lb,ub);

disp(x_optimal) %X0,X1,X2,Z1,Z2
disp(fval + const)
```
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
Assum = [0,0,0];
%Input weights and biases
Weights_layer1 = {
[1.842, -3.016, 0.039; 1.120, -0.045, 0.172; 1.122, -0.169, 0.235],  % Layer 1
[Assum; 1.120, -0.045, 0.172; 1.122, -0.169, 0.235],
[1.842, -3.016, 0.039; Assum; 1.122, -0.169, 0.235],
[1.842, -3.016, 0.039; 1.120, -0.045, 0.172; Assum],
[Assum;  Assum; 1.122, -0.169, 0.235],
[Assum; 1.120, -0.045, 0.172; Assum],
[1.842, -3.016, 0.039; Assum; Assum],
[Assum; Assum; Assum]};

Weights_layer2 = {
[0.215, -0.936, -0.412; 0.267, -0.536, -0.649; -0.191, 0.578, -0.571],  % Layer 2
[Assum; 0.267, -0.536, -0.649; -0.191, 0.578, -0.571],  
[0.215, -0.936, -0.412; Assum; -0.191, 0.578, -0.571],  
[0.215, -0.936, -0.412; 0.267, -0.536, -0.649; Assum],  
[Assum; Assum; -0.191, 0.578, -0.571],  
[Assum; 0.267, -0.536, -0.649; Assum],  
[0.215, -0.936, -0.412; Assum; Assum],  
[Assum; Assum; Assum]
};

Weights_layer3 = [-0.555, -0.119, 0.948]  % Layer 3

Biases_layer1 = {
[-0.392; 1.209; 0.301],  % Layer 1
[0; 1.209; 0.301],
[-0.392; 0; 0.301],
[-0.392; 1.209; 0],
[0; 0; 0.301],
[0; 1.209; 0],
[-0.392; 0; 0],
[0; 0; 0]
}

Biases_layer2 = {
[1.804; -1.293; -1.339],  % Layer 2
[0; -1.293; -1.339],
[1.804; 0; -1.339],
[1.804; -1.293; 0],
[0; 0; -1.339],
[0; -1.293; 0],
[1.804; 0; 0],
[0; 0; 0]}


Biases_layer3 = [0.065]  % Layer 3


% Ignore the constant in objective function temporarily
const = Biases_layer3;

for i = 1:8
    for j = 1:8
        % Parameters setting
        Z = [0, -1.08, 0];
        C = [-2475, 4703, 0];
        I = eye(3);
        O = zeros(3,3);
        
        % Optimization
        % Variables: X0, X1, X2, [3*1]

        % Objective function
        f = [-Z, [0,0,0], Weights_layer3]; % -AX0 + 0X1 + W2X2

        A = [C,[0,0,0],[0,0,0]];

        b = [2475.6];

        Aeq = [Weights_layer1{i},-I,O;
               O,Weights_layer2{j},-I];
           
        beq = [-Biases_layer1{i}; 
               -Biases_layer2{j}];

        ub = [[1;1;1]; [inf;inf;inf]; [inf;inf;inf]]; % Upper bound
        lb = [[-1;-1;-1]; [0;0;0]; [0;0;0]]; % Lowwer bound

        [x_optimal, fval, exitflag] = linprog(f,A,b,Aeq,beq,lb,ub);
        if fval < -2.1049
            disp(x_optimal);%X0,X1,X2,Z1,Z2
            disp(fval + const);
        else
            disp(' ');
        end
    end
end
```
%
%
% Define the weights and biases
weights = {
[1.842, -3.016, 0.039; 1.120, -0.045, 0.172; 1.122, -0.169, 0.235],  % Layer 1
[0.215, -0.936, -0.412; 0.267, -0.536, -0.649; -0.191, 0.578, -0.571],  % Layer 2
[-0.555, -0.119, 0.948]  % Layer 3
};
biases = {
[-0.392; 1.209; 0.301],  % Layer 1
[1.804; -1.293; -1.339],  % Layer 2
[0.065]  % Layer 3
};

x = [-0.9661; -1; -1];
O = [0;0;0];
% Calculate the activations for each layer
z1 = weights{1} * x + biases{1};
a1 = max(O, z1); % ReLU activation for Layer 1

z2 = weights{2} * a1 + biases{2};
a2 = max(O, z2); % ReLU activation for Layer 2

g = weights{3} * a2 + biases{3} - [0, -1.08, 0] * x; % Output of the network

disp(g)
'''
After the comparison, when 
$$
X_{0} = [x_{01},x_{02},x_{03}] = [-0.9661; -1; -1]
$$
$$
optimal = -2.1123
$$
## Write a Lagrangian dual problem of the MILP problem in part (a) such that any dual function can be calculated by solving two independent optimization problems, where one optimization problem includes output variables of the second hidden layer and the output layer and the other optimization problem includes output variables of the input layer and the first hidden layer. (6 marks)
%
%
%
%
