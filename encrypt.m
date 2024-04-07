function [out_img,key] = encrypt(img)
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
[h,w,d]=size(img);
key=hash(double(img),'SHA-256');

key_array=generate_init(key,1,1,2,2);

K=hyperchaos(key_array,h*w*d);

out_img=uint8(RNA_encrypt(img,K,key));
end

