function oimg = RNA_encrypt(img,K,key)
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

%��ͼƬת���ɻ��������Ӿ���
c_mask=uint8(ones(n,n)*63);
cmatrix=c_mask-matrix;


%��keyת��Ϊ�������ַ���
% ��������ÿ��Ԫ��ת��Ϊ�������ַ���
key_bit = dec2bin(key,8);

% ���������ַ�������ÿ��Ԫ�����ӳ�һ�����ַ���
key_bit = reshape(key_bit.', 1, []);

%ΪC������ӳ�ʼ��
C=zeros(n+1,n);
T=zeros(n,1);
T(:)=12;
C(1,:)=T;
C(2:end,:)=double(cmatrix);

%����������˳��
temp_order=order(1:n,1);
[temp_order,index]=sort(temp_order);
order1=[1;index+1];

%��һ���в���
keycounter=0;
for i =2:n+1
    startkey=mod(keycounter,length(key_bit)-1)+1;
    keycounter=keycounter+1;
    key_temp=key_bit(startkey:startkey+1);
    C1=C(order1(i),:);
    C2=C(order1(i-1),:)+1;
    if (key_temp(1)=='0' && key_temp(2)=='0')
        C(order1(i),:)=bitxor(C1,mod(T00(C2)'+reshape(mask(1,order1(i)-1,:),1,n),64));
    elseif (key_temp(1)=='0' && key_temp(2)=='1')
        C(order1(i),:)=bitxor(C1,mod(T01(C2)'+reshape(mask(1,order1(i)-1,:),1,n),64));
    elseif (key_temp(1)=='1' && key_temp(2)=='0')
        C(order1(i),:)=bitxor(C1,mod(T10(C2)'+reshape(mask(1,order1(i)-1,:),1,n),64));
    else
        C(order1(i),:)=bitxor(C1,mod(T11(C2)'+reshape(mask(1,order1(i)-1,:),1,n),64));
    end  

end

C(1,:)=C(order1(end),:);


%�ڶ����в���
TC=C;
keycounter=0;
for i =2:n+1
    startkey=mod(keycounter,length(key_bit)-1)+1;
    keycounter=keycounter+1;
    key_temp=key_bit(startkey:startkey+1);
    C1=TC(order1(i),:);
    C2=C(i-1,:)+1;
    if (key_temp(1)=='0' && key_temp(2)=='0')
        C(i,:)=bitxor(C1,mod(T00(C2)'+reshape(mask(2,i-1,:),1,n),64));
    elseif (key_temp(1)=='0' && key_temp(2)=='1')
        C(i,:)=bitxor(C1,mod(T01(C2)'+reshape(mask(2,i-1,:),1,n),64));
    elseif (key_temp(1)=='1' && key_temp(2)=='0')
        C(i,:)=bitxor(C1,mod(T10(C2)'+reshape(mask(2,i-1,:),1,n),64));
    else
        C(i,:)=bitxor(C1,mod(T11(C2)'+reshape(mask(2,i-1,:),1,n),64));
    end  
end

C=C(2:end,:);

%ΪC������ӳ�ʼ��
D=zeros(n,n+1);
T=zeros(n,1);
T(:)=23;
D(:,1)=T;
D(:,2:end)=C;

%����������˳��
temp_order=order(1:n,2);
[temp_order,index]=sort(temp_order);
order2=[1;index+1];

%��һ���в���
keycounter=0;
for i =2:n+1
    startkey=mod(keycounter,length(key_bit)-1)+1;
    keycounter=keycounter+1;
    key_temp=key_bit(startkey:startkey+1);
    D1=D(:,order2(i));
    D2=D(:,order2(i-1))+1;
    if (key_temp(1)=='0' && key_temp(2)=='0')
        D(:,order2(i))=bitxor(D1,mod(T00(D2)+reshape(mask(3,:,order2(i)-1),n,1),64));
    elseif (key_temp(1)=='0' && key_temp(2)=='1')
        D(:,order2(i))=bitxor(D1,mod(T01(D2)+reshape(mask(3,:,order2(i)-1),n,1),64));
    elseif (key_temp(1)=='1' && key_temp(2)=='0')
        D(:,order2(i))=bitxor(D1,mod(T10(D2)+reshape(mask(3,:,order2(i)-1),n,1),64));
    else
        D(:,order2(i))=bitxor(D1,mod(T11(D2)+reshape(mask(3,:,order2(i)-1),n,1),64));
    end  
end
D(:,1)=D(:,order2(end));


%�ڶ����в���
TD=D;
keycounter=0;
for i =2:n+1
    startkey=mod(keycounter,length(key_bit)-1)+1;
    keycounter=keycounter+1;
    key_temp=key_bit(startkey:startkey+1);
    D1=TD(:,order2(i));
    D2=D(:,i-1)+1;
    if (key_temp(1)=='0' && key_temp(2)=='0')
        D(:,i)=bitxor(D1,mod(T00(D2)+reshape(mask(4,:,i-1),n,1),64));
    elseif (key_temp(1)=='0' && key_temp(2)=='1')
        D(:,i)=bitxor(D1,mod(T01(D2)+reshape(mask(4,:,i-1),n,1),64));
    elseif (key_temp(1)=='1' && key_temp(2)=='0')
        D(:,i)=bitxor(D1,mod(T10(D2)+reshape(mask(4,:,i-1),n,1),64));
    else
        D(:,i)=bitxor(D1,mod(T11(D2)+reshape(mask(4,:,i-1),n,1),64));
    end  
end
D=D(:,2:end);

oimg=sbittoebit(D,h,w,d);



end

