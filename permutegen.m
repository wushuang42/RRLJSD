function order = permutegen(n,K)
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
order=zeros(n,2);
for i=1:2
    seq=mod(K((i-1)*n+1:(i-1)*n+n,5)*10000, 1);
% ʹ��sort�����������������򣬵õ�������ֵ�Ͷ�Ӧ������
    [sorted_vals, sorted_inds] = sort(seq);
% ʹ��tiedrank��������ÿ��Ԫ�ص�˳��ֵ
    ranks = tiedrank(seq);
% ����˳��ֵ��ԭ�������л���
    order(sorted_inds,i) = ranks;
end


end

