function px=poLagrange (xi,yi,x)

% function px=poLagrange (xi,yi,x)
% Dados os nós e respectivos valores nodais na forma dos vectores 
% xi e yi, respectivamente, usa a fórmula de Lagrange para calcular
% o valor do polinómio interpolador no ponto x

n=length(xi)-1;    % o grau do polinómio é n
px=0;
for i=1:n+1  % Li(x)=num/den;
    num=1; den=1;      
    for j=1:n+1
        if (j~=i)
            num=num*(x-xi(j));
            den=den*(xi(i)-xi(j));
        end
    end
    px=px+yi(i)*(num/den); 
end
