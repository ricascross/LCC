function x=GaussElimPP(A,b)
% resolve o sistema Ax=b pelo método de eliminação de Gauss 
% com pivotação parcial(PP); 

n=length(b);
for k=1:n-1
    [~,p]=max(abs(A(k:n,k))); p=p+k-1; % indice corrigido da linha pivotal 
                                        
    if p~=k
        A([k p],k:n)=A([p k],k:n) % troca linhas k <-->p da +arte ativa da matriz
        b([k p])=b([p k]);        % troca b(k) <--> b(p)
    end
    for i=k+1:n
        m(i,k)=A(i,k)/A(k,k);                  
        for j=k+1:n   
            A(i,j)=A(i,j)-m(i,k)*A(k,j);
        end
        b(i)=b(i)-m(i,k)*b(k);
    end
end
x=STriangular(A,b);

