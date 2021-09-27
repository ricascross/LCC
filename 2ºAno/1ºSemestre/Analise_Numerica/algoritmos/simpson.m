function Q=simpson(funcao,a,b,n)
% function Q=simpson(funcao,a,b,n)
% Usa a regra composta de Simpson para aproximar o valor do integral de f
% no intervalo [a,b]; 
% divide o intervalo em n subintervalos de igual amplitude; n deve ser par

f=fcnchk(funcao);   
h=(b-a)/n;
Q=f(a)+f(b);
x=a+h:2*h:b-h;
Q=Q+4*sum(f(x));
x=a+2*h:2*h:b-2*h; 
Q=Q+2*sum(f(x));
Q=Q*h/3;