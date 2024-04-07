function o_img = decrypt(eimg,key)
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
[h,w,d]=size(eimg);

key_array=generate_init(key,1,1,2,2);

K=hyperchaos(key_array,h*w*d);

o_img=RNA_decrypt(eimg,K,key);
end

