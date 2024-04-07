function [gen_ori_table,c_table,random_index1,random_index2]=RNAcodoncreate(gen_base,K)
[col,row]=size(K);
K=gen_K_round(K,64);
K_series=zeros(col,1);
for i=1:row
    K_series=K_series+K(:,i);
end

for i =1:4
    for j =1:4
        for k =1:4
            
            temp=[gen_base(i),gen_base(j),gen_base(k)];
            output=[dec2bin(i-1,2),dec2bin(j-1,2),dec2bin(k-1,2)];
            gen_ori_table.(temp)=output;
        end
    end
end
ori_index=[1:64;1:64];
c_table=c_change(gen_ori_table);

random_index1=ori_index;
array=K_series(1:floor(col/128):col);
random_index1(2,:)=array(1:64);
random_index1=sortrows(random_index1.',2);
random_index2=ori_index;
random_index2(2,:)=array(65:128);
random_index2=sortrows(random_index2.',2);