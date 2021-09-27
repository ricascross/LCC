function bits=intdectobin(N)
% Dado (na base 10) um n�mero N, inteiro positivo, d� a representa��o
% bin�ria bits, na forma de um vetor de bits
% Exerc�cio 3.a da folha 1

bits=[];  % inicializa o vetor de bits
q=N;      % inicializa��o do quociente das divis�es sucessivas por 2
while q>=2
    bits=[rem(q,2),bits]; % rem(q/2) d� o resto na divis�o inteira de q por 2
    q=floor(q/2);
end
bits=[q,bits]; % o bit mais � esquerda � o �ltimo quociente



