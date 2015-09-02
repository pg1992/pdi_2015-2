function [img_res, img_all_labels, n_holes, n_spots, n_spots_with_holes, n_spots_without_holes, holes_per_spot] = holes_no_holes(img)
% [img_res, img_all_labels, n_holes, n_spots, n_spots_with_holes, n_spots_without_holes, holes_per_spot] = holes_no_holes(img)
% 
% Descrição:
% 	Esta função retorna várias informações relacionadas a manchas e buracos em IMG.
% 
% Entrada:
% 	img: imagem binária a ser analisada.
% Saída:
% 	img_res: contém 2 labels, um para manchas com buracos e outro para
% 		manchas sem buracos.
% 	img_all_labels: tudo é rotulado com um rótulo diferente, tanto manchas
% 		quanto buracos.
% 	n_holes: quantos buracos existem na imagem.
% 	n_spots: quantas manchas existem na image.
% 	n_spots_with_holes: quantas manchas com buracos.
% 	n_spots_without_holes: quantas manchas sem buracos.
% 	holes_per_spot: um vetor onde cada índice representa uma mancha
% 		e cada valor corresponde a quantos buracos tem na respectiva mancha.

[img_spots, n_spots] = find_spots(img);

% A rotulação das manchas da imagem inversa nada mais é do que
% a rotulação dos buracos (exceto o fundo)
[img_holes, n_holes] = find_spots(~img);

% O fundo não é considerado um buraco
n_holes = n_holes - 1;

% É preciso saber qual o label do fundo e então eliminá-lo.
% Para isso cria-se um vetor com os píxeis da borda ...
border_holes_values = ...
	[img_holes(1,:)'
	img_holes(size(img,1),:)'
	img_holes(2:size(img,1)-1,1)
	img_holes(2:size(img,1)-1,size(img,2))];

% ... então encontra-se o índice dos que não tem label 0 ...
border_label_index = find(border_holes_values ~= 0);
% ... e, portanto, o label do fundo é o label do primeiro
% elemento que não for igual a zero.
border_label = border_holes_values(border_label_index(1));

% Elimina-se o label do fundo deixando ele igual a zero
img_holes = (img_holes ~= border_label) .* img_holes;
% Para que os labels sejam uma sequência:
img_holes = (img_holes > border_label) .* (img_holes - 1) ...
	+ (img_holes < border_label) .* img_holes;

% Para encontrar as manchas sem buracos e já rotuladas é
% só fazer a união das imagens com buracos e os buracos e rotular o resultado
[img_full, n_full] = find_spots((img_holes ~= 0) + (img_spots ~= 0));

%--------------------------------------------------------------------------------
% A rotina abaixo basicamente faz a combinação de cada mancha com buraco
% e sem, encontra a interseção das duas e compara a área para saber
% se as manchas são correspondentes e se ela tem ou não buracos para
% fazer a rotulação

n_spots_with_holes = 0;
n_spots_without_holes = 0;
no_hole_label = 1;
hole_label = 2;
img_res = zeros(size(img));

for i=1:n_spots
	for j=1:n_full
		img_intersect = (img_spots == i) & (img_full == j);
		if sum(img_intersect(:)) == 0
			continue;
		elseif (sum(sum(img_intersect == (img_spots == i))) ~= ...
			sum(sum(img_intersect == (img_full == j))))
			img_res = img_res + img_intersect * hole_label;
			n_spots_with_holes = n_spots_with_holes + 1;
			continue;
		else
			img_res = img_res + img_intersect * no_hole_label;
			n_spots_without_holes = n_spots_without_holes + 1;
			continue;
		end
	end
end

%--------------------------------------------------------------------------------
% A rotina abaixo identifica quantos buracos existem por mancha
% identificando, para cada buraco, o label mais próximo, que é
% o da mancha o qual ele faz parte.

% Inicializa um vetor com 0 buracos por mancha.
holes_per_spot = zeros(n_spots, 1);

% Os primeiros labels são das manchas, e a partir do label
% n_spots + 1, todos são buracos.
img_all_labels = img_spots + (img_holes > 0) .* (img_holes + n_spots);

for level=n_spots+1:n_spots+n_holes
	[vec_i vec_j] = find(img_all_labels == level);
	[vec_i sort_idx] = sort(vec_i);
	vec_j = vec_j(sort_idx);
	
	% O label da mancha correspondente ao buraco de label 'level'
	% é o label do que está acima do menor i da região (qualquer
	% pixel da vizinhança daria certo...)
	relative_spot = img_all_labels(vec_i(1)-1,vec_j(1));
	holes_per_spot(relative_spot) = holes_per_spot(relative_spot) + 1;
end

end
