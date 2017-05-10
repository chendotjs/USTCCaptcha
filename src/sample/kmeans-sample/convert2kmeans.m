% 将 m*n*p 的三维矩阵转换为 mn * p的二维矩阵
% 特征选取：rgb颜色 + 位置
function [vec, Ib ,Ig, coor]= convert2kmeans(file, alpha)
  I = imread(file);
  I = clearNoise(I);

  thresh = graythresh(I);     %自动确定二值化阈值
  Ib = im2bw(I,thresh);       %对图像二值化
  Ig = rgb2gray(I);

  [x, y, z] = size(I);
  index = 1;

  for i = 2:x - 1
    for j = 2:y -1
      t = Ig(i, j);
      t = [alpha * i;alpha * j;t]; % 携带位置信息
      if Ib(i, j) == 0
        vec(index, :) = double(t);
        coor(index, :) = [i, j];
        index = index + 1;
      end
    end
  end
end


function Iimg = clearNoise(I)
  [x, y, z] = size(I);
  Iimg = I;
  for i = 1:x
    for j = 1:y
      if Iimg(i, j, 1) >= 210 && Iimg(i, j, 1) <= 220 ...
        && Iimg(i, j, 2) >= 210 && Iimg(i, j, 2) <= 220 ...
        && Iimg(i, j, 3) >= 210 && Iimg(i, j, 3) <= 220
        Iimg(i, j, 1) = 250;
        Iimg(i, j, 2) = 250;
        Iimg(i, j, 3) = 250;
      end
    end
  end
end
