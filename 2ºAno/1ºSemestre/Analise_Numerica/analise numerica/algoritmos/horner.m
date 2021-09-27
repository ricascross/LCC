function [px] = horner(a,x)
% Dado um polin�mio atrav�s do vetor a dos seus coeficientes e um ponto x
% usa o m�todo de Horner para calcular o valor do polin�mio no ponto dado

n=length(a)-1; % grau do polin�mio
px=a(1);
for i=2:n+1
    px=x*px+a(i);
end


end

