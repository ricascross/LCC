
function T = trapezios (f, a, b, n)
h = (b-a)/n;
T = (f(a)+f(b))/2;
x = a+h:h:b-h;
T = T+sum(f(x));
T= h*T;

endfunction