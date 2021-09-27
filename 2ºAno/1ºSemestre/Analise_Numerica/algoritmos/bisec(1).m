function [raiz, funevals] = bisec(f, a, b, tol)
% function [raiz, funevals]=bisec(fun, a, b, tol)
% Dados:
%       uma função continua fun
%       os extremos a e b de um intervalo que contém pelo menos um zero de
%       fun
%       a tolerância tol,
% esta função implementa o método da bisecção para aproximar um zero de f; 
% termina quando obtem um intervalo de amplitude menor que tol e toma como
% aproximação raiz o valor médio desse intervalo; funevals é o número de
% vezes que a função é calculada.
 
fa=f(a); fb=f(b);
if fa==0
    raiz=a; 
    funevals= 'Não foram feitas iterações';
elseif fb==0
    raiz=b; 
    funevals= 'Não foram feitas iterações';
elseif fa*fb >0
    raiz=' fa*fb >0: não há garantia de existir uma raíz entre a e b';
    funevals= 'Não foram feitas iterações';
else
    funevals=0;                    % numero de vezes que se calcula f
    while b-a > tol
            med = (a + b)/2;           % o ponto médio do intervalo [a,b] que contem o zero
            fmed=f(med);
            funevals=funevals+1;
            if fmed*fa < 0             % há um zero de f em [a, med]
                b=med;
                fb=fmed; 
            elseif fmed*fb < 0         % há um zero de f em [med, b]
                a=med;
                fa=fmed; 
            else                       % med é zero de p
                a=med;
                b=med;
            end
    end
    raiz=(a+b)/2;
end


