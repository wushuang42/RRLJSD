 function [T00,T01,T10,T11] = codonTgen(K)
%UNTITLED6 此处显示有关此函数的摘要
%   此处显示详细说明
T00=zeros(64,1);T01=zeros(64,1);T10=zeros(64,1);T11=zeros(64,1);

seq=mod(K(1:64,1)*10000, 1);
% 使用sort函数对向量进行排序，得到排序后的值和对应的索引
[sorted_vals, sorted_inds] = sort(seq);
% 按照顺序值对原向量进行回填
T00 = sorted_inds-1;
if sum(mod(T00,1))>0
    pause(1)
end
seq=mod(K(1:64,2)*10000, 1);
% 使用sort函数对向量进行排序，得到排序后的值和对应的索引
[sorted_vals, sorted_inds] = sort(seq);

% 按照顺序值对原向量进行回填
T01 = sorted_inds-1;
if sum(mod(T01,1))>0
    pause(1)
end
seq=mod(K(1:64,3)*10000, 1);
% 使用sort函数对向量进行排序，得到排序后的值和对应的索引
[sorted_vals, sorted_inds] = sort(seq);

% 按照顺序值对原向量进行回填
T10 = sorted_inds-1;
if sum(mod(T10,1))>0
    pause(1)
end
seq=mod(K(1:64,4)*10000, 1);
% 使用sort函数对向量进行排序，得到排序后的值和对应的索引
[sorted_vals, sorted_inds] = sort(seq);
% 按照顺序值对原向量进行回填
T11 = sorted_inds-1;
if sum(mod(T11,1))>0
    pause(1)
end
end

