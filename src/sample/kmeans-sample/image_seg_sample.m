clc;clear;

alpha = 1;

[vec,Ib, Ig, coor]= convert2kmeans('../../../train/3000_6_character/429NE6.bmp', alpha);

[idx, C] = kmeans(vec(:,1:2), 6); %TODO: 为什么这里加了灰度信息反而效果不好？ 可能不需要alpha？ 只需对特征进行正规化？

result = [vec, idx];

figure(7);
imshow(Ib);

for cluster = 1:6
  showCluster(Ib, idx, coor, vec, cluster);
end


figure(8);
Ibcentroid = ones(size(Ib));
for i=1:size(C)
  x = C(i,1);
  y = C(i,2);
  x = uint32(x);
  y = uint32(y);
  Ibcentroid(x,y) = 0;
end
imshow(Ibcentroid);
