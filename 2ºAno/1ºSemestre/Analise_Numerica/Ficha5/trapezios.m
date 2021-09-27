
function T = trapezios (f, a, b, n)
h = (b-a)/n;
T = (f(a)+f(b))/2;
i = 1;
while i < n-1
  T = T + f(a + i*h);
end
T= h*T;

endfunction
