
function [px] = horner (a, x)
 % Dado um polinómio através do vetor a dos seus coeficientes e um ponto x
% usa o método de Horner para calcular o valor do polinómio no ponto dado

n=length(a)-1; %grau do polinómio
px = a(1);
for i=2:n+1
  px=x*px+a(i);
end

endfunction
