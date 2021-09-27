function T=TabDifDiv(x,f)
% function T=TabDifDiv(x,f)
% Dados os vectores x (nós) e f (valores nodais), constrói a tabela das
% diferenças divididas na forma de uma matriz triangular inferior T; a primeira coluna 
% da matriz T armazena o vector f dos valores nodais, a segunda coluna armazena as 
% diferenças divididas de primeira ordem, etc.; as diferenças divididas a
% usar na fórmula interpoladora de Newton estão na diagonal principal de T

n = length(x)-1;            % ordem da diferença dividida de maior ordem a calcular 
T(:,1)=f(:);
for j=2:n+1
    for i=j:n+1
        T(i,j)=((T(i,j-1))-(T(i-1,j-1)))/(x(i)-x(i-j+1));
    end
end

