clear all; close all; clc;

tic

number_of_images = 4;

img_res = {};
img_all_labels = {};
n_holes = zeros(number_of_images,1);
n_spots = zeros(number_of_images,1);
n_spots_with_holes = zeros(number_of_images,1);
n_spots_without_holes = zeros(number_of_images,1);
holes_per_spot = {};

try
	load('imgs.mat');
catch
	for i=1:number_of_images
		img = imread(sprintf('fig%i.jpg', i));
		try
			img = rgb2gray(img);
		end
		img = img < (max(img(:)) + min(img(:)))/2;
		
		[img_res{i}, img_all_labels{i},  n_holes(i), n_spots(i), n_spots_with_holes(i), ...
		n_spots_without_holes(i), holes_per_spot{i}] = ...
			holes_no_holes(img);
		save('imgs.mat', 'img_res', 'img_all_labels', 'n_holes', 'n_spots', ...
		'n_spots_with_holes', 'n_spots_without_holes',  'holes_per_spot');
	end
end

for i=1:number_of_images
	figure(1);
	subplot(2,2,i); imshow(label2rgb(img_all_labels{i}));
	title_text = [sprintf('Número de manchas com buracos = %i\n', n_spots_with_holes(i)) ...
		sprintf('Número de manchas sem buracos = %i', n_spots_without_holes(i))];
	title(title_text);

	figure(2);
	subplot(2,2,i); imshow(label2rgb(img_res{i}));
	title(title_text);

	disp_text = [];
	disp_text = [sprintf('\nFigura %i:\n', i)];
	disp_text = [disp_text sprintf('Número de manchas = %i', n_spots(i))];
	disp_text = [disp_text sprintf('\nNúmero de buracos = %i', n_holes(i))];
	disp_text = [disp_text sprintf('\nNúmero de manchas com buracos = %i', ...
		n_spots_with_holes(i))];
	disp_text = [disp_text sprintf('\nNúmero de manchas sem buracos = %i', ...
		n_spots_without_holes(i))];
	for j=1:length(holes_per_spot{i})
		disp_text = [disp_text ...
			sprintf('\nMancha %i tem %i buracos', j, holes_per_spot{i}(j))];
	end
	disp(disp_text);
end

toc
