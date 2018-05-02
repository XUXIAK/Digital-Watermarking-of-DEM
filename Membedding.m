function z2 = Membedding(w,z)
%DEM嵌入策略，w为水印，z为高程矩阵，z需要比w多一列 
[m,n]=size(w); 
for i=1:m
    for j=1:n 
        d=abs(z(i,j+1)-z(i,j));
        if (w(i,j)==0) & (mod(d,2)==1)
            z(i,j+1)=z(i,j+1)-1;
        elseif (w(i,j)==1) & (mod(d,2)==0)
            z(i,j+1)=z(i,j+1)+1;
        end
    end
end
z2=z;
end