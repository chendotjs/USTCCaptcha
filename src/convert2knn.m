clc;clear;
load trainData.mat;

knnChars = [];
knnLabels = [];
for i = 1:length(chars)/25
  vec = reshape(chars(:, 25 * i: 25 * i + 24), 1, 625);
  knnChars = [knnChars;vec];
end

for i = 1:length(labels)
  knnLabels = [knnLabels;labels(i)];
end

save trainData_knn knnChars knnLabels;
