% 对特征矩阵聚类
% params:
%   featureVec: 特征矩阵
%   k: 聚类个数
% return values:
%   idx: 每一行对应的聚类类别
%   C: 聚类中心(前两列) + 分类的标签
% Extended description
function [idx, C] = kmeans_cluster(featureVec, k)

  while 1
    [idx, C] = kmeans(featureVec(:,1:2), k); % TODO: 目前只取坐标。为什么这里加了灰度信息反而效果不好？ 可能不需要alpha？ 只需对特征进行正规化？
    % 聚类的中心可能初始化不够好，需要检查聚类中心的排布
    C2 = sort(C(:,2)); % C2应该是个近似的等差数列
    CInterval = C2(2:end) - C2(1:end-1);  % CInterval应该是个近似相等的数列
    if var(CInterval) < 6 % 方差的阈值, 如果聚类效果不好的话，方差会达到大几十
      break;
    end
  end
  C = [C, (1:k)']; % 带上聚类的标签
  C = sortrows(C, 2); % 按照从左往右的顺序排序
end  % function
