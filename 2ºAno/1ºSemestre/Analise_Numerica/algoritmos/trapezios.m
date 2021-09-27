function T=trapezios(funcao,a,b,n)
% function Q=trapezios(funcao,a,b,n)
% Usa a regra composta dos trapezios para aproximar o valor do integral de f
% no intervalo [a,b]; divide o intervalo em n subintervalos de igual amplitude;

f=fcnchk(funcao);   
h=(b-a)/n;
T=(f(a)+f(b))/2;
x=a+h:h:b-h;
T=T+sum(f(x));
T=T*h;

