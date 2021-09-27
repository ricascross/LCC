function bits=fracdectobin(Dec)
% Determina a representa��o bin�ria de um n�mero fracion�rio puro
% dado na base 10 (algoritmo das multiplica��es sucessivas)

bits=[];  % inicializa o vetor dos bits da rep. bin�ria
while Dec~=0
    prod=2*Dec;
    partint=floor(prod);
    bits=[bits, partint];
    Dec=prod-partint;
end


