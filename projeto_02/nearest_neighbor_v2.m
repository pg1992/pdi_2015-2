function I_interp = nearest_neighbor_v2(I, ratio)
% I_interp = nearest_neighbor_v1(I, ratio)
% 
% Description:
%   This function returns an image which is RATIO times
%   greater than I with the extra pixels filled
%   with the nearest pixel in I in terms of distance.
% 
% Input:
%   I: the source image
%   ratio: the size ratio of the resulting image
% 
% Output:
%   I_interp: the resulting image with the extra pixels
%   interpolated

I_interp = uint8(zeros(round(ratio * size(I))));

i_index = round(linspace(1, size(I,1), size(I_interp,1)));
j_index = round(linspace(1, size(I,2), size(I_interp,2)));

I_interp = I(i_index, j_index);

end
