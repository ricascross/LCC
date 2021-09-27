function [bin] = intdectobin (x)

bin = [];
while x>1
  bin = [rem(x,2), bin];
  x = floor(x/2);
end
  bin = [x,bin];
endfunction
