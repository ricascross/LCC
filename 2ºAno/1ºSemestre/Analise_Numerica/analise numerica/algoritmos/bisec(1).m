function [raiz, funevals] = bisec(f, a, b, tol)
% function [raiz, funevals]=bisec(fun, a, b, tol)
% Dados:
%       uma fun��o continua fun
%       os extremos a e b de um intervalo que cont�m pelo menos um zero de
%       fun
%       a toler�ncia tol,
% esta fun��o implementa o m�todo da bisec��o para aproximar um zero de f; 
% termina quando obtem um intervalo de amplitude menor que tol e toma como
% aproxima��o raiz o valor m�dio desse intervalo; funevals � o n�mero de
% vezes que a fun��o � calculada.
 
fa=f(a); fb=f(b);
if fa==0
    raiz=a; 
    funevals= 'N�o foram feitas itera��es';
elseif fb==0
    raiz=b; 
    funevals= 'N�o foram feitas itera��es';
elseif fa*fb >0
    raiz=' fa*fb >0: n�o h� garantia de existir uma ra�z entre a e b';
    funevals= 'N�o foram feitas itera��es';
else
    funevals=0;                    % numero de vezes que se calcula f
    while b-a > tol
            med = (a + b)/2;           % o ponto m�dio do intervalo [a,b] que contem o zero
            fmed=f(med);
            funevals=funevals+1;
            if fmed*fa < 0             % h� um zero de f em [a, med]
                b=med;
                fb=fmed; 
            elseif fmed*fb < 0         % h� um zero de f em [med, b]
                a=med;
                fa=fmed; 
            else                       % med � zero de p
                a=med;
                b=med;
            end
    end
    raiz=(a+b)/2;
end


