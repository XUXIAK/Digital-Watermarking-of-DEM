function z2 = Membedding(w,z)
%DEMǶ����ԣ�wΪˮӡ��zΪ�߳̾���z��Ҫ��w��һ�� 
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