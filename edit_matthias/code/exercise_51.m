clear;
% a)
x = sdpvar(1,1);y = sdpvar(1,1);
p = 2 + x^2 + x^2*y^4 - 4*x^1*y^1;
F = sos(p);
solvesos(F);
q = sosd(F);
sdisplay(clean(q, 1e-6))

% b)
sdpvar x1 x3 c
h = x3^6 - 3*x1^2*x3^2 + x1^2 + x1^4;
F = sos(h + c);
solvesos(F, c,[],c)
value(c)