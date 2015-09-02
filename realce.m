clear all; close all; clc;

I = imread('Baboon.bmp');
% % imshow(I);
% figure; subplot(1,2,1); imshow(I); subplot(1,2,2); imshow(imadjust(I, [0 1], [1 0]));
% % figure; subplot(1,2,1); imshow(I); subplot(1,2,2); imshow(imcomplement(I));
% figure; subplot(1,2,1); imshow(I); subplot(1,2,2); imshow(imadjust(I, [0.5 0.75], [0 1]));
% figure; subplot(1,2,1); imshow(I); subplot(1,2,2); imshow(imadjust(I, [], [], 2));

a = [.5 .25 .15 .1 .09];
m = [50 100 200];

imadjustsig = @(I,a,m)(uint8(255./(1 + exp(-a*(double(I)-m)))));

for i=1:length(a)
	for j=1:length(m)
		figure; subplot(1,2,1); imshow(I); subplot(1,2,2); imshow(imadjustsig(I, a(i), m(j)));
		title(sprintf('a = %.2f, m = %i', a(i), m(j)));
	end
end
