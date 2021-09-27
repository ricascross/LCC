function pz=polNewton(x,f,z)

% function pz=polNewton(x,f,z)
% Dados os vectores x (n�s), f (valores nodais) e z, usa a f�rmula
% de Newton com diferen�as divididas para calcular o valor do polin�mio
% interpolador no ponto z
% Usa a fun��o TabDifDiv para calcular as diferen�as divididas

n=length(x)-1;
T=TabDifDiv(x,f); 
pz=T(n+1,n+1);
for k=n:-1:1
  pz=pz*(z-x(k))+T(k,k);
end


