function I_quant = quantize(I, nbits)
% I_quant = quantize(I, nbits)
% 
% Description:
%   This function takes an 8-bit image and quatizes
%   it to a number of bits 1 <= NBITS <= 8.
% 
% Input:
%   I: the source image
%   nbits: how many bits that the resulting image will have
% 
% Output:
%   I_quant: the resulting quantized image

factor = 2^(8 - nbits + 1) - 1;
I_quant = uint8(floor(I / factor) * factor);

end
