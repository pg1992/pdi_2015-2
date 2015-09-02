function [img_res, n_holes, n_no_holes] = holes_no_holes(img)

[img_spots, n_spots] = find_spots(img);
[img_holes, n_holes] = find_spots(~img);

border_holes_values = ...
	[img_holes(1,:)'
	img_holes(size(img,1),:)'
	img_holes(2:size(img,1)-1,1)
	img_holes(2:size(img,1)-1,size(img,2))];

border_label_index = find(border_holes_values ~= 0);
border_label = border_holes_values(border_label_index(1));

img_holes = (img_holes ~= border_label) .* img_holes;
[img_full, n_full] = find_spots((img_holes ~= 0) + (img_spots ~= 0));

n_holes = 0;
n_no_holes = 0;

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
			n_holes = n_holes + 1;
			continue;
		else
			img_res = img_res + img_intersect * no_hole_label;
			n_no_holes = n_no_holes + 1;
			continue;
		end
	end
end

end
