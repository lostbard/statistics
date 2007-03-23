## Copyright (C) 2001 Paul Kienzle
##  modified (C) 2003 Alois Schloegl 
##
## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 2 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program; if not, write to the Free Software
## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA

## [v, idx] = nanmin(X [, Y]);
## nanmin is identical to the min function except that NaN values are
## are ignored.  If all values in a column are NaN, the minimum is 
## returned as NaN rather than []. 
##
## See also: nansum, nanmax, nanmean, nanmedian
function [v, idx] = nanmin (X, Y, DIM) 
  if nargin < 1 || nargin > 2
    usage ("[v, idx] = nanmin(X [, Y, [DIM]])");
  elseif nargin == 1 || (nargin == 2 && isempty(Y))
    nanvals = isnan(X);
    X(nanvals) = Inf;
    v = min (X);
    v(all(nanvals)) = NaN;
  elseif (nargin == 3 && isempty(Y))
    nanvals = isnan(X);
    X(nanvals) = Inf;
    v = min (X,[],DIM);
    v(all(nanvals)) = NaN;
  else
    Xnan = isnan(X);
    Ynan = isnan(Y);
    X(Xnan) = Inf;
    Y(Ynan) = Inf;
    if (nargin == 3)
      v = min(X,Y,DIM);
    else
      v = min(X,Y);
    endif
    v(Xnan & Ynan) = NaN;
  endif
endfunction
