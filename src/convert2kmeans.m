% 返回用于聚类的特征矩阵
% 特征选取：坐标 + 灰度值
% params:
%   file: 图片的路径
%   alpha: 调整灰度和坐标之间的比重
% return value:
%   featureVec: 用于聚类的特征矩阵
%   Ib: 原图的二值图像
%   Ig: 原图的灰度图
%   coor: 和featureVec的行数一样，对应着featureVec每一行矩阵表示的坐标
function [featureVec, Ib ,Ig, coor]= convert2kmeans(file, alpha)
  I = imread(file);
  I = clearNoise(I);    % 去噪点

  Ig = rgb2gray(I);           % 转成灰度图
  Ib = im2binar(Ig, 230);       % 对图像二值化

  [x, y, z] = size(I);
  index = 1;

  for i = 2:x - 1     % 去掉边框，边框的像素点不参与聚类
    for j = 2:y -1
      t = [i, j, alpha * Ig(i, j)]; % 每个像素的特征 ，携带位置信息及灰度值
      if Ib(i, j) == 0    % 如果这里是字符的一部分
        featureVec(index, :) = double(t);
        coor(index, :) = [i, j];
        index = index + 1;
      end
    end
  end
end

% 把背景中灰色的噪点去掉
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

% 把灰度图转成二值图， thresh是区分白色和其他颜色的阈值
function Ib = im2binar(Ig, thresh)
  [x, y] = size(Ig);
  Ib = Ig;
  for i = 1:x
    for j = 1:y
      if Ig(i, j) <= thresh
        Ib(i, j) = 0;
      else
        Ib(i, j) = 1;
      end
    end
  end
  Ib = mat2gray(Ib);
end
