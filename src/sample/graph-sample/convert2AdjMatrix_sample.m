clear;clc;

img1 = [1     0     0     1 ;
        0     1     0     0 ;
        0     1     1     0 ;
        0     0     0     1 ;
        1     1     0     1 ;]

graph1  = convert2AdjMatrix(img1)


img2 = [
1 1 1;
0 1 1;
1 1 0]

graph2 = convert2AdjMatrix(img2)

fprintf('SCC of img1:\n');
adjMatrix_dfs(2, img1, graph1, 2)

fprintf('SCC of img2:\n');
adjMatrix_dfs(1, img2, graph2, 1)
