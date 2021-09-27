
function [soma, n]=expTaylor(x, tol)

% calcula a soma dos primeiros n termos da s�rie de Taylor para a fun��o
% exponencial exp(x); termina quando encontrar um termo cujo valor absoluto
% � inferior a uma toler�ncia tol.

termo=1;
soma=0;
n=0;
while abs(termo)> tol
    soma = soma + termo;
    n=n+1;
    termo = termo*x/n;
end
n=n-1;


