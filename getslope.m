function y = getslope(dem,cellsize)
%GET SLPOE 
dem=double(dem);
dis=2*cellsize; 
 [m,n]=size(dem);   
 slope=zeros(m,n);  
 %对DEM边缘进行处理，外扩一圈0，用于边缘坡度值的计算
 dem2=[zeros(1,n);dem;zeros(1,n)];  
 dem2=[zeros(m+2,1),dem2,zeros(m+2,1)]; 
 
 for i=1:m 
     for j=1:n 
     dx=(dem2(i,j)-dem2(i+2,j))/dis; 
     dy=(dem2(i,j)-dem2(i,j+2))/dis;
     slope(i,j)=atand((dx^2+dy^2)^0.5);
     end 
 end 
 y=slope;
end

