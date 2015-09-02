clear all; close all; clc;

warning('OFF');

try
	load('all_data');
catch
	m = 4;
	
	medias = zeros(m,1);
	desvios = zeros(m,1);
	
	I = {};
	j = {};
	accum = {};
	
	for i=1:m
		[I{i}, jumps{i}] = intensity();
		medias(i) = mean(jumps{i});
		desvios(i) = std(jumps{i});

		accum{i} = zeros(size(jumps{i}));
		accum{i}(1) = jumps{i}(1);
		for j=2:length(jumps{i})
			accum{i}(j) = accum{i}(j-1) + jumps{i}(j);
		end
	end
	
	save('all_data', 'I', 'jumps', 'medias', 'desvios', 'accum', 'm');
end

for i=1:4
	figure(1);
	subplot(2,2,i);
	imshow(I{i});
	
	figure(2);
	subplot(2,2,i);
	stem(jumps{i}, 'k', ...
		'linewidth', 2, ...
		'markerfacecolor', 'k', ...
		'markeredgecolor', 'k', ...
		'markersize', 5);
	xlabel('passo');
	ylabel('salto');
	title(sprintf('media de salto = %.2f, desvio = %.2f', ...
		medias(i), desvios(i)));

	figure(3);
	subplot(2,2,i);
	plot(accum{i}, 'k', 'linewidth', 2);
	xlabel('passo');
	ylabel('acumulado');
end
