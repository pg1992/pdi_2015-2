clear all;
close all;

I = imread('tire.tif');
[h, w] = size(I);
n = length(I(:));
[nk rk] = hist(I(:), [0:255]);
subplot(2,2,3);
stem(rk, nk);
ps = nk/n;

sk = ps;

for i = 2:length(ps)
	sk(i) = sk(i) + sk(i-1);
end

subplot(2,2,1);
imshow(I)

for i = 1:h
	for j = 1:w
		Ih(i,j) = round(255*sk(I(i,j)+1));
	end
end

subplot(2,2,2);
imshow(uint8(Ih))

[nk rk] = hist(Ih(:), [0:255]);
subplot(2,2,4);
stem(rk, nk);
