function w = extract( z )
%水印提取方法  
[m,n]=size(z); 
w=zeros(m,n-1);
for i=1:m 
    for j=1:n-1  
        d=abs(z(i,j+1)-z(i,j));
        if mod(d,2)==0 
            w(i,j)=0;
        elseif mod(d,2)==1
            w(i,j)=1; 
        end
    end 
end

end

