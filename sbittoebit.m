function omat = sbittoebit(mat,h,w,d)
%UNTITLED5 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
[n,n]=size(mat);

% ������ת��Ϊ������
mat_vec = reshape(mat, [], 1);
% ÿ8λ�ָ�һ�Σ���ת��Ϊ����
result_vec = bi2de(reshape(de2bi(mat_vec, 6, 'left-msb'), [], 8), 'left-msb');
% ���������ת��Ϊ1024*1024��С
omat = reshape(result_vec, h,w,d);
end
