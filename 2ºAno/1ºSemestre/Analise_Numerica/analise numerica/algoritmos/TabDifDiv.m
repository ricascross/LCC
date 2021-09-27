function T=TabDifDiv(x,f)
% function T=TabDifDiv(x,f)
% Dados os vectores x (n�s) e f (valores nodais), constr�i a tabela das
% diferen�as divididas na forma de uma matriz triangular inferior T; a primeira coluna 
% da matriz T armazena o vector f dos valores nodais, a segunda coluna armazena as 
% diferen�as divididas de primeira ordem, etc.; as diferen�as divididas a
% usar na f�rmula interpoladora de Newton est�o na diagonal principal de T

n = length(x)-1;            % ordem da diferen�a dividida de maior ordem a calcular 
T(:,1)=f(:);
for j=2:n+1
    for i=j:n+1
        T(i,j)=((T(i,j-1))-(T(i-1,j-1)))/(x(i)-x(i-j+1));
    end
end

