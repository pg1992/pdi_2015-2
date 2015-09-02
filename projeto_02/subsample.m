function I_sub = subsample(I,n)
% I_sub = subsample(I, n)
% 
% Description:
%   I_SUB has only 1 pixel of each NxN block of I.
% 
%   Example: consider the image
% 
%   I = [a11 a12 a13 a14;
%        a21 a22 a23 a24;
% 	   a31 a32 a33 a34]
% 
%   the resulting image subsample(I, 2) would simply be
% 
%   [a11 a13;
%    a31 a33]
% 
% Input:
%   I: the source image
%   n: the size of the block
% 
% Output:
%   I_sub: the resulting image

I_sub = I(1:n:end,1:n:end);

end
