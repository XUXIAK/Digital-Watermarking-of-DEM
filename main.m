 
% path_qr= 'D:\毕业论文\实验\图像置乱\qr_copyright.png';
% qr=imread(path_qr); 
% qr=im2bw(qr,0.5);
path_wm='D:\毕业论文\实验\图像置乱\qr147.png';  
wm=imread(path_wm);
wm=im2bw(wm,0.5);
path_dem='D:\毕业论文\实验\data\dem.tif'; 
[dem, R] = geotiffread(path_dem);
[m1,n1]=size(wm); 
[m2,n2]=size(dem);  
%x,y分别为dem分块数，x0,y0为余下无法拼为整块的数据
x=floor(m2/m1); x0=mod(m2,m1);    
y=floor(n2/(n1+1)); y0=mod(n2,(n1+1)); 
div_x=[ones(1,x)*m1,x0]; 
div_y=[ones(1,y)*(n1+1),y0]; 
dem_block=mat2cell(dem,div_x,div_y);%对DEM数据进行分块处理 
slope=getslope(dem,30);  
mean_slope=mean2(slope);
slope_block=mat2cell(slope,div_x,div_y);
for i=1:x 
    for j=1:y    
        if mean2(slope_block{i,j}) > mean_slope
        dem_block{i,j}=Membedding(wm,dem_block{i,j}); 
        end
    end
end
wm_dem=cell2mat(dem_block);  
clear i j m1 m2 n1 n2 x0 y0 slope slope_block;
%提取水印
% w=cell(x,y); 
% for i=1:x 
%     for j=1:y 
%       w{i,j}=extract(dem_block{i,j}); 
%       w{i,j}=arnold(w{i,j},21);
%     end
% end
% w2=cell2mat(w);figure;imshow(w2);
% subplot(2,2,1); imshow(dem,[]); title('无水印DEM'); 
% subplot(2,2,2); imshow(wm_dem,[]); title('有水印DEM'); 

   
% geotiffwrite('slope_dem.tif',slope,R);
% slope_wmdem=getslope(wm_dem,30);geotiffwrite('slope_wmdem.tif',slope_wmdem,R);
% geotiffwrite('wm_dem.tif',wm_dem,R);
