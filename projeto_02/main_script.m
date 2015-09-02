clear all; close all; clc;

img = uint8(imread('Lena.bmp'));

figure(1);
subplot(2,3,1);
imshow(img);
title('Imagem original: 512 x 512');

figure(2);
subplot(2,3,1);
imshow(img);
title('Imagem original: 512 x 512');

img_sub = {};
img_nn = {};

for i=1:4
	img_sub{i} = subsample(img, 2^i);
	img_nn{i} = nearest_neighbor_v1(img_sub{i}, 2^i);

	figure(1);
	subplot(2,3,i+1);
	imshow(img_sub{i});
	title(sprintf('Resolução: %i x %i', size(img_sub{i},1), size(img_sub{i},2)));

	figure(2);
	subplot(2,3,i+1);
	imshow(img_nn{i});
	title(sprintf('Resolução: %i x %i', size(img_nn{i},1), size(img_nn{i},2)));
end

img2 = uint8(imread('Baboon.bmp'));
img_q = {};
bits = [8, 4, 2, 1];

for i=1:4
	img_q{i} = quantize(img2, bits(i));
	figure(3);
	subplot(2,2,i);
	imshow(img_q{i});
	title(sprintf('%i bits', bits(i)));
end

figure;
subplot(1,2,1);
imshow(abs(imresize(img_sub{4}, [512 512], 'nearest') - nearest_neighbor_v1(img_sub{4}, 16)));
title('nearest\_neighbor\_v1');

subplot(1,2,2);
imshow(abs(imresize(img_sub{4}, [512 512], 'nearest') - nearest_neighbor_v2(img_sub{4}, 16)));
title('nearest\_neighbor\_v2');
