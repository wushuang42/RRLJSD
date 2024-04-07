function omat = ebittosbit(img)
%UNTITLED5 此处显示有关此函数的摘要
%   此处显示详细说明
[h,w,d]=size(img);
% 将图像矩阵转换为行向量
img_vec = reshape(img, [], 1);
% 每6位分割一次，并转换为整数
result_vec = bi2de(reshape(de2bi(img_vec, 8, 'left-msb'), [], 6), 'left-msb');
% 将结果矩阵转换为1024*1024大小
omat = reshape(result_vec, sqrt(h*w*d*8/6), []);
end

