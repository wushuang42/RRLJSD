function omat = sbittoebit(mat,h,w,d)
%UNTITLED5 此处显示有关此函数的摘要
%   此处显示详细说明
[n,n]=size(mat);

% 将矩阵转换为行向量
mat_vec = reshape(mat, [], 1);
% 每8位分割一次，并转换为整数
result_vec = bi2de(reshape(de2bi(mat_vec, 6, 'left-msb'), [], 8), 'left-msb');
% 将结果矩阵转换为1024*1024大小
omat = reshape(result_vec, h,w,d);
end
