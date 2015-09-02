function [I,jumps] = intensity(n,step)
% [I,jumps] = intensity(n,step)
%     [...] = intensity(n)
%     [...] = intensity()
%
% Description:
%   The gray level of the pixels range
%   from 0 to 255. A key press 
%   changes the gray level of the current
%   square, and a mouse click changes
%   the current square to the inner square.
% 
%   Inputs:
%     n: image size is n x n
%     step: how many pixels from the outer to the inner square
% 
%   Outputs:
%     I: the resulting image
%     jumps: the gray level jumps from the outer to the inner square

switch(nargin)
case 0
  n = 1024;
  step = 8;
case 1
  step = 8;
end % of switch

I = zeros(n);
i = -1;
k = 1;

handle = figure(1);

while (i < 256 && k*step < round(n/2))
	x = -20; y = -20;
	w = 1;
	while (w == 1 && i < 256)
		i = i + 1;
		I(k*step:n-k*step,k*step:n-k*step) = i/255;
		imshow(I);
		disp(sprintf('i = %i. Press a key to increase i or click to change square', i));
		w = waitforbuttonpress;
	end % of while 2
	disp('Mouse clicked. Changing the square');
	k = k + 1;
end % of while 1

close(handle);

jumps = I(1:step:k*step,round(n/2));
jumps = jumps(2:end) - jumps(1:end-1);

jumps = 255*jumps(:); % column vector

end % of function
