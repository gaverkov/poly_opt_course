U=rand(3,3);
A=U*U'
R=chol(A)
R'*R
V=sqrtm(A)
V'*V
