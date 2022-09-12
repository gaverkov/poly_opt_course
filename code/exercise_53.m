clear;
% set dimension (number of vertices)
n=6;
X=sdpvar(n,n);
% set known integer optimum
opt=9;
% define edge set
E = [[1,4]; [1,5]; [1,6]; [2,4]; [2,5]; [2,6]; [3,4]; [3,5]; [3,6]];

% initialize set of constraints
Constr = [];

% create norm constraints
for i = 1:n
    Constr = [Constr, X(i,i) == 1];
end

% create sdp constraint
Constr = [Constr, X >= 0]; 

% create objective
Obj = 0;

for m = 1:size(E,1)
    edge = E(m,:);
    Obj = Obj - 0.5 + 0.5*X(edge(1),edge(2));
end

% version for the case of a complete graph
% for i = 1:(n-1)
%     for j = (i+1):n
%         Obj = Obj - 0.5 + 0.5*X(i,j);
%     end
% end

optimize(Constr, Obj);
value(X)
value(Obj)
-opt/value(Obj)