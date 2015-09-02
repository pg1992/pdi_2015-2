clear all; close all; clc;

tic

img_res = {};
nholes = zeros(4,1);
n_no_holes = zeros(4,1);

try
	load('imgs.mat');
catch
	for i=4:4
		img = imread(sprintf('fig%i.jpg', i));
		try
			img = rgb2gray(img);
		end
		img = img < (max(img(:)) + min(img(:)))/2;
		
		[img_res{i}, nholes(i), nnoholes(i)] = holes_no_holes(img);
		save('imgs.mat', 'img_res', 'nholes', 'nnoholes');
	end
end

for i=1:4
	subplot(2,2,i); imshow(label2rgb(img_res{i}));
	title([sprintf('Número de manchas com buracos = %i', nholes(i)) ...
		sprintf('\nNúmero de manchas sem buracos = %i', nnoholes(i))]);
end

toc
