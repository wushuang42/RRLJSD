function dimg = RNA_decrypt(img,K,key)
%UNTITLED4 此处显示有关此函数的摘要
%   此处显示详细说明

[h,w,d]=size(img);
n=sqrt(h*w*d*8/6);

%将图片转换为6bit矩阵
matrix = ebittosbit(img);


%生成密码子索引表
[T00,T01,T10,T11] = codonTgen(K);

%生成随机数矩阵mask
mask=maskgen(K,img);

%生成置乱随机数序列
order=permutegen(n,K);

%将key转换为二进制字符串
% 将向量中每个元素转换为二进制字符串
key_bit = dec2bin(key,8);

% 将二进制字符串按照每个元素连接成一个长字符串
key_bit = reshape(key_bit.', 1, []);

%生成列置乱顺序
temp_order=order(1:n,2);
[temp_order,index]=sort(temp_order);
order2=[1;index+1];

%将第二次列操作反转
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
    


%为D矩阵添加初始列
T=zeros(n,1);
T(:)=23;
D=TD; 
D(:,1)=T;
  

%将第一次列操作反转
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



%生成行置乱顺序
temp_order=order(1:n,1);
[temp_order,index]=sort(temp_order);
order1=[1;index+1];

%将第二次行操作反转
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


%为C矩阵添加初始行
T=zeros(n,1);
T(:)=12;  
C=TC;
C(1,:)=T;

%将第一次行操作反转
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

%将互补密码子矩阵转换回原矩阵
c_mask=uint8(ones(n,n)*63);
dmatrix=c_mask-cmatrix;

dimg=sbittoebit(dmatrix,h,w,d);



end

