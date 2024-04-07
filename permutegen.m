function order = permutegen(n,K)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
order=zeros(n,2);
for i=1:2
    seq=mod(K((i-1)*n+1:(i-1)*n+n,5)*10000, 1);
% 使用sort函数对向量进行排序，得到排序后的值和对应的索引
    [sorted_vals, sorted_inds] = sort(seq);
% 使用tiedrank函数计算每个元素的顺序值
    ranks = tiedrank(seq);
% 按照顺序值对原向量进行回填
    order(sorted_inds,i) = ranks;
end


end

