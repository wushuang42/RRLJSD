 function [T00,T01,T10,T11] = codonTgen(K)
%UNTITLED6 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
T00=zeros(64,1);T01=zeros(64,1);T10=zeros(64,1);T11=zeros(64,1);

seq=mod(K(1:64,1)*10000, 1);
% ʹ��sort�����������������򣬵õ�������ֵ�Ͷ�Ӧ������
[sorted_vals, sorted_inds] = sort(seq);
% ����˳��ֵ��ԭ�������л���
T00 = sorted_inds-1;
if sum(mod(T00,1))>0
    pause(1)
end
seq=mod(K(1:64,2)*10000, 1);
% ʹ��sort�����������������򣬵õ�������ֵ�Ͷ�Ӧ������
[sorted_vals, sorted_inds] = sort(seq);

% ����˳��ֵ��ԭ�������л���
T01 = sorted_inds-1;
if sum(mod(T01,1))>0
    pause(1)
end
seq=mod(K(1:64,3)*10000, 1);
% ʹ��sort�����������������򣬵õ�������ֵ�Ͷ�Ӧ������
[sorted_vals, sorted_inds] = sort(seq);

% ����˳��ֵ��ԭ�������л���
T10 = sorted_inds-1;
if sum(mod(T10,1))>0
    pause(1)
end
seq=mod(K(1:64,4)*10000, 1);
% ʹ��sort�����������������򣬵õ�������ֵ�Ͷ�Ӧ������
[sorted_vals, sorted_inds] = sort(seq);
% ����˳��ֵ��ԭ�������л���
T11 = sorted_inds-1;
if sum(mod(T11,1))>0
    pause(1)
end
end

