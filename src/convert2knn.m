clc;clear;
load trainData.mat;

knnChars = [];
knnLabels = [];
for i = 1:length(chars)/25
  i
  vec = reshape(chars(:, 25 * (i-1) + 1: 25 * i), 1, 625);
  knnChars = [knnChars;vec];
end

for i = 1:length(labels)
  i
  knnLabels = [knnLabels;labels(i)];
end

save trainData_knn knnChars knnLabels;
