function [array]=generate_init(key,c1,c2,c3,c4)


key=double(key);    
K=abs(key);
xor_value = K(1);
for i = 2:8
    xor_value = bitxor(xor_value, K(i));
end
h1 = c1 + xor_value / 256;

xor_value = K(9);
for i = 10:16
    xor_value = bitxor(xor_value, K(i));
end
h2 = c2 + xor_value / 256;

xor_value = K(17);
for i = 18:24
    xor_value = bitxor(xor_value, K(i));
end
h3 = c3 + xor_value / 256;

xor_value = K(25);
for i = 26:32
    xor_value = bitxor(xor_value, K(i));
end
h4 = c4 + xor_value / 256;

x1 = mod((h1 + h2) * 1e14, 256) / 255;
x2 = mod((h2 + h3) * 1e14, 256) / 255;
x3 = mod((h3 + h4) * 1e14, 256) / 255;
x4 = mod((h1+h3) * 1e14, 256) / 255;
x5 = mod((h1+h4) * 1e14, 256) / 255;
x6 = mod((h2+h4) * 1e14, 256) / 255;
array=[x1,x2,x3,x4,x5,x6];
