

function x = soma (n)
  %n=100
x=0;
for k=1:n
  x=x+((-1)^k+1)*(1/(2*k-1));
end

endfunction
