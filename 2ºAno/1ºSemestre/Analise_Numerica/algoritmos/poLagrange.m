function px=poLagrange (xi,yi,x)

% function px=poLagrange (xi,yi,x)
% Dados os n�s e respectivos valores nodais na forma dos vectores 
% xi e yi, respectivamente, usa a f�rmula de Lagrange para calcular
% o valor do polin�mio interpolador no ponto x

n=length(xi)-1;    % o grau do polin�mio � n
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
