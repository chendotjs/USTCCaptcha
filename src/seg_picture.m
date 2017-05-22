% 将单幅图片分成k类，每个字符用N*N的二值图片表示
function [Centroids, cooridx, IbSet] = seg_picture(file, k,  N)
  [featureVec, Ib ,Ig, coor]= convert2kmeans(file, 1);
  [idx, Centroids] = kmeans_cluster(featureVec, k);
  cooridx = [coor, idx]; % 每个坐标对应的分类标签
  Centroids = round(Centroids); % 四舍五入聚类中心
  segCentroids = zeros(size(Centroids)); % 分割出来的二值图像的中心
  IbSet = [];
  freeSpace = 5;  % 左上角为旋转预留空间
  for i = 1:k
    icluster = coor(idx == Centroids(i, 3), :); % 从左向右的k个聚类
    segCentroids(i,:) = [Centroids(i,1) - min(icluster(:, 1)) + 1 + freeSpace, Centroids(i,2) - min(icluster(:, 2)) + 1 + freeSpace, Centroids(i,3)];
    icluster = [icluster(:, 1) - min(icluster(:, 1)) + 1 + freeSpace, icluster(:, 2) - min(icluster(:, 2)) + 1 + freeSpace]; % 重新把原点移动到最左上方
    Ib = makeCharImg(icluster, N);
    [rAngle, Irb] = rotateAndSqueeze(Ib, segCentroids(i,1), segCentroids(i,2), -20, 20); % 旋转并找到得到最小的宽度的角度
    IbSet = [IbSet, Irb];
    % for debug
    % figure();
    % imshow(Ib);
    % for debug
  end
end  % function


% N*N size image
function Ib = makeCharImg(icluster, N)
  Ib = ones(N, N);
  for i = 1:length(icluster)
    Ib(icluster(i,1), icluster(i,2)) = 0;
  end
  Ib = mat2gray(Ib);
end
