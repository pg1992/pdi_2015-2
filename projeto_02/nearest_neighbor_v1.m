function I_interp = nearest_neighbor_v1(I, n)
% I_interp = nearest_neighbor_v1(I, n)
% 
% Description:
%   This function returns an image which is N times
%   greater than I with the extra pixels filled
%   with a copy of the orinal pixels of I.
%   In other words, I_INTERP is simply the image
%   I interleaved with itself in an NxN grid.
% 
%   Example: consider the image
% 
%   I = [a11 a12;
%        a21 a22]
% 
%   the resulting imagem nearest_neighbor_v1(I, 3)
%   would simply be
% 
%   [a11 a11 a11  a12 a12 a12;
%    a11 a11 a11  a12 a12 a12;
%    a11 a11 a11  a12 a12 a12;
% 
%    a21 a21 a21  a22 a22 a22;
%    a21 a21 a21  a22 a22 a22;
%    a21 a21 a21  a22 a22 a22]
% 
% Input:
%   I: the source image
%   n: how many time I_INTERP will be bigger (an integer)
% 
% Output:
%   I_interp: the resulting image

I_interp = uint8(zeros(round(n) * size(I)));

for i=1:n
	for j=1:n
		I_interp(i:n:end,j:n:end) = I;
	end
end

end
