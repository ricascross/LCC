function x=GaussElim (A,b)
% resolve o sistema Ax=b pelo metodo de eliminaçao de Gauss sem pivotaçao
% usa a function STriangular que implementa o metodo de substituicao
% inversa para matrizes triangulares superiores;
n=length(b);
for k=1:n-1  
    for i=k+1:n
        m=A(i,k)/A(k,k);        
        A(i,k:n)=A(i,k:n)-m*A(k,k:n); 
        b(i)=b(i)-m*b(k);
    end
end
x=STriangular(A,b);

