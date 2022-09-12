clear;
sdpvar x y lb;
f = -5 + 6*x + 10*y + 6*x^2 + 6*y^2 - 22*x*y - x^4 - 2*x^2*y^2 - y^4 + 2*x*y^2 + 2*x^2*y
g = [x - 0.5; y - 0.5; 1 - x*y];
g4 = [5 - x^2 - y^2]; % special polynomial
d = 2;
% lets hope that quadratic multipliers suffice. If they don't we can try
% larger degrees later
[s1,c1] = polynomial([x y],d);
[s2,c2] = polynomial([x y],d);
[s3,c3] = polynomial([x y],d);
[s4,c4] = polynomial([x y],d);
[s5,c5] = polynomial([x y],d);

%F = [sos(f-lb-[s1 s2 s3]*g - s4), sos(s1), sos(s2), sos(s3), sos(s4)];
%solvesos(F, -lb, [], [c1; c2; c3; c4; lb]) 
F = [sos(f-lb-[s1 s2 s3]*g - s4 - s5*g4), sos(s1), sos(s2), sos(s3), sos(s4), sos(s5)];
solvesos(F, -lb, [], [c1; c2; c3; c4; c5; lb])
value(lb)
