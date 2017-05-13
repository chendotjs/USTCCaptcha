% usage: listFiles('../test/*.bmp')
% return value:
%   filelist 300*8 char
%   listStruct 300*1 struct
function [filelist, listStruct]  = listFiles(path)
  listStruct = dir(path);
  filelist = [];
  for i = 1:length(listStruct)
    ltmp =listStruct(i);
    filelist = [filelist; ltmp.name];
  end
end
