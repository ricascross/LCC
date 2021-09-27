function x=STriangular(A,b)
% implementa o metodo de substitui�ao inversa para resolver o sistema 
% Ax=b, sendo A uma matriz triangular superior 

n=length(b);
x(n,1)=b(n)/A(n,n); % substitui�ao inversa
for i=n-1:-1:1
    j=i+1:n;
    x(i)=(b(i)-A(i,j)*x(j))/A(i,i);
end
   

