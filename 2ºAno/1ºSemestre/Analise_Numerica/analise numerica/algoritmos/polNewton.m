function pz=polNewton(x,f,z)

% function pz=polNewton(x,f,z)
% Dados os vectores x (nós), f (valores nodais) e z, usa a fórmula
% de Newton com diferenças divididas para calcular o valor do polinómio
% interpolador no ponto z
% Usa a função TabDifDiv para calcular as diferenças divididas

n=length(x)-1;
T=TabDifDiv(x,f); 
pz=T(n+1,n+1);
for k=n:-1:1
  pz=pz*(z-x(k))+T(k,k);
end


