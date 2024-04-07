function mask = maskgen(K,img)
%UNTITLED7 此处显示有关此函数的摘要
%   此处显示详细说明

[h,w,d]=size(img);
n=sqrt(h*w*d*8/6);
mask=zeros(4,n,n);
for i=1:4
    seq=mod(floor(K(:,i)*10000),256);
    mask(i,:,:)=ebittosbit(seq);
end


end

