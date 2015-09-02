function [img_res, num_labels] = find_spots(I)

I = padarray(I, [1 1]);

img_res = zeros(size(I));

k = 1;

for i=2:size(I,1)-1
	for j=2:size(I,2)-1
		if I(i,j) == 0
			continue;
		else
			if I(i-1,j) == 0 && I(i,j-1) == 0
				img_res(i,j) = k;
				k = k + 1;
				continue;
			elseif I(i-1,j) == 0 && I(i,j-1) == 1
				img_res(i,j) = img_res(i,j-1);
				continue;
			elseif I(i-1,j) == 1 && I(i,j-1) == 0
				img_res(i,j) = img_res(i-1,j);
				continue;
			elseif I(i-1,j) == 1 && I(i,j-1) == 1
				img_res(i,j) = img_res(i,j-1);
				img_res = (img_res == img_res(i-1,j)) * img_res(i,j-1) ...
					+ (img_res ~= img_res(i-1,j)) .* img_res;
				continue;
			end
		end
	end
end

label = 1;
for i=1:k-1
	if sum(img_res(:) == i) > 0
		img_res = (img_res == i) * label + (img_res ~= i) .* img_res;
		label = label + 1;
	end
end

num_labels = label-1;

sz_1 = size(img_res,1);
sz_2 = size(img_res,2);

img_res = img_res(2:sz_1-1, 2:sz_2-1);

end
