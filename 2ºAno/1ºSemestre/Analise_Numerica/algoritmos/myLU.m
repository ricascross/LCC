function A=myLU (A)
% Dada uma matriz A, quadrada, determina os fatores L, triangular inferior
% com unidades na diagonal principal e U, triangular superior, tais que 
% A=L*U; As posições relevantes da matriz L são armazenadas no mesmo array A
% abaixo da diagonal principal; A matriz U está na parte triangular
% superior

n=length(A);
for k=1:n-1  
    for i=k+1:n
        m=A(i,k)/A(k,k);
        A(i,k)=m;
        A(i,k+1:n)=A(i,k+1:n)-m*A(k,k+1:n); 
    end
end

