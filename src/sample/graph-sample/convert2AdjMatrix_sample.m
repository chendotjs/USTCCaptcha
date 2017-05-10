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

fprintf('biggest SCC of img1:\n');
adjMatrix_dfs(graph1, 1,[])

fprintf('one of SCC of img1:\n');
adjMatrix_dfs(graph1, 4,[])

fprintf('biggest SCC of img2:\n');
adjMatrix_dfs(graph2, 1,[])
