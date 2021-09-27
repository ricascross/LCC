

function [soma, n] = expTaylor (x,tol)
  % calcula a soma dos primeiros n termos da série de Taylor para a função
% exponencial exp(x); termina quando encontrar um termo cujo valor absoluto
% é inferior a uma tolerância tol.

soma = 0;
n = 0;
termo=1;
while abs(termo) > tol
  soma = soma + termo;
  n = n+1;
  termo = termo*x/n;
end
n=n-1;
endfunction
