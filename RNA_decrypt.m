function dimg = RNA_decrypt(img,K,key)
%UNTITLED4 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

[h,w,d]=size(img);
n=sqrt(h*w*d*8/6);

%��ͼƬת��Ϊ6bit����
matrix = ebittosbit(img);


%����������������
[T00,T01,T10,T11] = codonTgen(K);

%�������������mask
mask=maskgen(K,img);

%�����������������
order=permutegen(n,K);

%��keyת��Ϊ�������ַ���
% ��������ÿ��Ԫ��ת��Ϊ�������ַ���
key_bit = dec2bin(key,8);

% ���������ַ�������ÿ��Ԫ�����ӳ�һ�����ַ���
key_bit = reshape(key_bit.', 1, []);

%����������˳��
temp_order=order(1:n,2);
[temp_order,index]=sort(temp_order);
order2=[1;index+1];

%���ڶ����в�����ת
TD=zeros(n,n+1);
D=zeros(n,n+1);
D(:,2:end)=double(matrix); 
keycounter=1;
for i =3:n+1
    startkey=mod(keycounter,length(key_bit)-1)+1;
    keycounter=keycounter+1;
    key_temp=key_bit(startkey:startkey+1);
    D2=D(:,i-1)+1;
    if (key_temp(1)=='0' && key_temp(2)=='0')
        TD(:,order2(i))=bitxor(D(:,i),mod(T00(D2)+reshape(mask(4,:,i-1),n,1),64));
    elseif (key_temp(1)=='0' && key_temp(2)=='1')
        TD(:,order2(i))=bitxor(D(:,i),mod(T01(D2)+reshape(mask(4,:,i-1),n,1),64));
    elseif (key_temp(1)=='1' && key_temp(2)=='0')
        TD(:,order2(i))=bitxor(D(:,i),mod(T10(D2)+reshape(mask(4,:,i-1),n,1),64));
    else
        TD(:,order2(i))=bitxor(D(:,i),mod(T11(D2)+reshape(mask(4,:,i-1),n,1),64));
    end  
end

startkey=1;
key_temp=key_bit(startkey:startkey+1);
if (key_temp(1)=='0' && key_temp(2)=='0')
    TD(:,order2(2))=bitxor(D(:,2),mod(T00(TD(:,order2(end))+1)+reshape(mask(4,:,1),n,1),64));
elseif (key_temp(1)=='0' && key_temp(2)=='1')
    TD(:,order2(2))=bitxor(D(:,2),mod(T01(TD(:,order2(end))+1)+reshape(mask(4,:,1),n,1),64));
elseif (key_temp(1)=='1' && key_temp(2)=='0')
    TD(:,order2(2))=bitxor(D(:,2),mod(T10(TD(:,order2(end))+1)+reshape(mask(4,:,1),n,1),64));
else
    TD(:,order2(2))=bitxor(D(:,2),mod(T11(TD(:,order2(end))+1)+reshape(mask(4,:,1),n,1),64));
end  
    


%ΪD������ӳ�ʼ��
T=zeros(n,1);
T(:)=23;
D=TD; 
D(:,1)=T;
  

%����һ���в�����ת
keycounter=0;
for i =2:n+1
    startkey=mod(keycounter,length(key_bit)-1)+1;
    keycounter=keycounter+1;
    key_temp=key_bit(startkey:startkey+1);
    D1=D(:,order2(i));
    D2=D(:,order2(i-1))+1;
    if (key_temp(1)=='0' && key_temp(2)=='0')
        TD(:,order2(i))=bitxor(D1,mod(T00(D2)+reshape(mask(3,:,order2(i)-1),n,1),64));
    elseif (key_temp(1)=='0' && key_temp(2)=='1')
        TD(:,order2(i))=bitxor(D1,mod(T01(D2)+reshape(mask(3,:,order2(i)-1),n,1),64));
    elseif (key_temp(1)=='1' && key_temp(2)=='0')
        TD(:,order2(i))=bitxor(D1,mod(T10(D2)+reshape(mask(3,:,order2(i)-1),n,1),64));
    else
        TD(:,order2(i))=bitxor(D1,mod(T11(D2)+reshape(mask(3,:,order2(i)-1),n,1),64));
    end  
end
Cmat=TD(:,2:end);



%����������˳��
temp_order=order(1:n,1);
[temp_order,index]=sort(temp_order);
order1=[1;index+1];

%���ڶ����в�����ת
TC=zeros(n+1,n);
C=zeros(n+1,n);
C(2:end,:)=Cmat; 

keycounter=1;
for i =3:n+1
    startkey=mod(keycounter,length(key_bit)-1)+1;
    keycounter=keycounter+1;
    key_temp=key_bit(startkey:startkey+1);
    C2=C(i-1,:)+1;
    if (key_temp(1)=='0' && key_temp(2)=='0')
        TC(order1(i),:)=bitxor(C(i,:),mod(T00(C2)'+reshape(mask(2,i-1,:),1,n),64));
    elseif (key_temp(1)=='0' && key_temp(2)=='1')
        TC(order1(i),:)=bitxor(C(i,:),mod(T01(C2)'+reshape(mask(2,i-1,:),1,n),64));
    elseif (key_temp(1)=='1' && key_temp(2)=='0')
        TC(order1(i),:)=bitxor(C(i,:),mod(T10(C2)'+reshape(mask(2,i-1,:),1,n),64));
    else
        TC(order1(i),:)=bitxor(C(i,:),mod(T11(C2)'+reshape(mask(2,i-1,:),1,n),64));
    end  
end

startkey=1;
key_temp=key_bit(startkey:startkey+1);
if (key_temp(1)=='0' && key_temp(2)=='0')
    TC(order1(2),:)=bitxor(C(2,:),mod(T00(TC(order1(end),:)+1)'+reshape(mask(2,1,:),1,n),64));
elseif (key_temp(1)=='0' && key_temp(2)=='1')
    TC(order1(2),:)=bitxor(C(2,:),mod(T01(TC(order1(end),:)+1)'+reshape(mask(2,1,:),1,n),64));
elseif (key_temp(1)=='1' && key_temp(2)=='0')
    TC(order1(2),:)=bitxor(C(2,:),mod(T10(TC(order1(end),:)+1)'+reshape(mask(2,1,:),1,n),64));
else
    TC(order1(2),:)=bitxor(C(2,:),mod(T11(TC(order1(end),:)+1)'+reshape(mask(2,1,:),1,n),64));
end      


%ΪC������ӳ�ʼ��
T=zeros(n,1);
T(:)=12;  
C=TC;
C(1,:)=T;

%����һ���в�����ת
keycounter=0;
for i =2:n+1
    startkey=mod(keycounter,length(key_bit)-1)+1;
    keycounter=keycounter+1;
    key_temp=key_bit(startkey:startkey+1);
    C1=C(order1(i),:);
    C2=C(order1(i-1),:)+1;
    if (key_temp(1)=='0' && key_temp(2)=='0')
        TC(order1(i),:)=bitxor(C1,mod(T00(C2)'+reshape(mask(1,order1(i)-1,:),1,n),64));
    elseif (key_temp(1)=='0' && key_temp(2)=='1')
        TC(order1(i),:)=bitxor(C1,mod(T01(C2)'+reshape(mask(1,order1(i)-1,:),1,n),64));
    elseif (key_temp(1)=='1' && key_temp(2)=='0')
        TC(order1(i),:)=bitxor(C1,mod(T10(C2)'+reshape(mask(1,order1(i)-1,:),1,n),64));
    else
        TC(order1(i),:)=bitxor(C1,mod(T11(C2)'+reshape(mask(1,order1(i)-1,:),1,n),64));
    end  
end

cmatrix=uint8(TC(2:end,:));

%�����������Ӿ���ת����ԭ����
c_mask=uint8(ones(n,n)*63);
dmatrix=c_mask-cmatrix;

dimg=sbittoebit(dmatrix,h,w,d);



end

