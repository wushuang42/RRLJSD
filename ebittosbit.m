function omat = ebittosbit(img)
%UNTITLED5 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
[h,w,d]=size(img);
% ��ͼ�����ת��Ϊ������
img_vec = reshape(img, [], 1);
% ÿ6λ�ָ�һ�Σ���ת��Ϊ����
result_vec = bi2de(reshape(de2bi(img_vec, 8, 'left-msb'), [], 6), 'left-msb');
% ���������ת��Ϊ1024*1024��С
omat = reshape(result_vec, sqrt(h*w*d*8/6), []);
end

