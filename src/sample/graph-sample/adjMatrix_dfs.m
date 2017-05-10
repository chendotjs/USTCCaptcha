% TODO: 对邻接矩阵进行深度搜索，获得所有连通分支
% 初步想法： 随机抛点，规模小于阈值的连通分支不需要，循环直到达到所要聚类的个数
function [set, delegate] = adjMatrix_dfs(adjMatrix, startPoint_id, nset)
  global adjMvisited;

  adjMvisited = zeros(1, length(adjMatrix)); % 每次查找单个连通分支时候都需要初始化visited
  adjMatrix_p_dfs(adjMatrix, startPoint_id, nset)
end

% 对邻接矩阵进行深度搜索，获得单个连通分支，需要指定一个起始点进行深度搜索
function [set, bimgPosSet] = adjMatrix_p_dfs(adjMatrix, startPoint_id, nset)
  global adjMvisited
  adjMvisited(startPoint_id) = 1;

  [x, y] =  size(adjMatrix);

  set = [nset, startPoint_id];

  for i = 1:y
    if adjMatrix(startPoint_id, i) == 1 && adjMvisited(i) == 0
      set = adjMatrix_p_dfs(adjMatrix, i, set);
    end
  end
end

function coor = recoverPos(adjMatrix_id, img_x, img_y)
  coor = [0 0];
  coor(2) = rem(adjMatrix_id, img_x);
  coor(1) = floor(adjMatrix_id / img_x);
end

function adjMatrix_id = mPos (coor_x, coor_y, img_x, img_y)
  adjMatrix_id =  (coor_x - 1) * img_y + coor_y;
end
