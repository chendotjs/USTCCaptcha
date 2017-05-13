clc;clear;

imgLists  =  dir('../../../train/3000_6_character/*.bmp');

randIndex = unidrnd(length(imgLists)); % 随机抽取一张训练集图片

[vec,Ib, Ig, coor]= convert2kmeans(['../../../train/3000_6_character/', imgLists(randIndex).name], 1);

while 1
  [idx, C] = kmeans(vec(:,1:2), 6); %TODO: 为什么这里加了灰度信息反而效果不好？ 可能不需要alpha？ 只需对特征进行正规化？
  % 聚类的中心可能初始化不够好，需要检查聚类中心的排布
  C2 = sort(C(:,2)); % C2应该是个近似的等差数列
  CInterval = C2(2:end) - C2(1:end-1);  % CInterval应该是个近似相等的数列
  CInterval
  var(CInterval)
  if var(CInterval) < 6 % 方差的阈值, 如果聚类效果不好的话，方差会达到大几十
    break;
  end
end

result = [vec, idx];

figure();
imshow(Ib);

for cluster = 1:6
  showCluster(Ib, idx, coor, vec, cluster);
end

% 绘制聚类中心
figure();
Ibcentroid = ones(size(Ib));
for i=1:size(C)
  x = uint32(C(i,1));
  y = uint32(C(i,2));
  Ibcentroid(x,y) = 0;
end
imshow(Ibcentroid);
