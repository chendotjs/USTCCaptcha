clear;clc;

img1 = [1     0     0     1 ;
        0     1     0     0 ;
        0     1     1     0 ;
        0     0     0     1 ;
        1     1     0     1 ;]

graph1  = convert2AdjMatrix(img1)


img2 = [1 1 1; 0 1 1; 1 1 0]

graph2 = convert2AdjMatrix(img2)
