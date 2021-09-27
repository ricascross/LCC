## Copyright (C) 2019 Ricascross
## 
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {} {@var{retval} =} Gauss (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Ricascross <ricascross@ricascross>
## Created: 2019-12-02

function [A b] = Gauss (A, b)
n=length(b);  
for j = 1:n-1
  for i=j+1:n
    m = -A(i,j)/A(j,j);
    A(i,j:n) = A(i,j:n)+m*A(j,j:n);
    b(i) = b(i)+m*b(j);
    A(i,j)=0;
  end 
end

endfunction
