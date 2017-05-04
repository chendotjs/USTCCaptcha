clc;clear;

I = convert2kmeans('../../../train/3000_6_character/429NE6.bmp');

function vec = convert2kmeans(file)
  I = imread(file);
  [x, y, z] = size(I);
  vec = zeros(x * y, z);

  for i = 1:x
    for j = 1:y
      t = I(x, y, :);
      t = t(:);
      index = (i - 1) * y + j;
      vec(index, :) = t';
      t'
    end
  end

end
