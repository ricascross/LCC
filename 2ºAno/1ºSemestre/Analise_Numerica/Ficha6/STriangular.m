function x=STriangular(A,b)
% implementa o metodo de substituiçao inversa para resolver o sistema 
% Ax=b, sendo A uma matriz triangular superior 

n=length(b);
x(n,1)=b(n)/A(n,n); % substituiçao inversa
for i=n-1:-1:1
    j=i+1:n;
    x(i)=(b(i)-A(i,j)*x(j))/A(i,i);
end
   

