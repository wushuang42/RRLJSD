clc
clear
path='..\testimages\lena.tif';



% ��ȡ��ɫͼ��
img=imread(path);



tic

[e_img,key]=encrypt(img);
toc

d_img=decrypt(e_img,key);

imshow(d_img);
