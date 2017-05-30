clear;clc;
load trainData_knn.mat;

KNEAREST = 10;

Mdl = fitcknn(knnChars, knnLabels, 'NumNeighbors', KNEAREST);

testFilesName = listFiles('../test_seg/*.bmp'); % 图片的名字
testFilesPath = strcat('../test_seg/', testFilesName); % 图片的完整路径

num = length(testFilesName);

correctCnt = 0;
for i = 1:num
  Ib = im2bw(imread(testFilesPath(i,:)));
  Ib = double(Ib);
  label = knn_predict(Mdl, Ib);
  fprintf('%c %c\n', testFilesName(i,1), label);
  if testFilesName(i,1) == label
    correctCnt = correctCnt + 1;
  end
end

fprintf('correct count: %d\n', correctCnt)

fprintf('correct rate: %f\n', correctCnt / num)
