%读取水印图像并二值化 
[filename, pathname] = uigetfile({'*.png';'*.jpg';'*.bmp';'*.*'}, '加载水印图像'); 
path_wm= [pathname filename];  
wm=imread(path_wm);
wm=im2bw(wm,0.5);
%读取DEM数据 
[filename, pathname] = uigetfile({'*.tif'}, '加载DEM数据'); 
path_dem= [pathname filename];  
[dem, R] = geotiffread(path_dem); 

[m1,n1]=size(wm); 
[m2,n2]=size(dem);  
%x,y分别为dem分块数，x0,y0为余下无法拼为整块的数据
x=floor(m2/m1); x0=mod(m2,m1);    
y=floor(n2/(n1+1)); y0=mod(n2,(n1+1)); 
div_x=[ones(1,x)*m1,x0]; 
div_y=[ones(1,y)*(n1+1),y0]; 
dem_block=mat2cell(dem,div_x,div_y);%对DEM数据进行分块处理 
 %计算每个分块的坡度值
slope=getslope(dem,30);  mean_slope=mean2(slope); 
slope_block=mat2cell(slope,div_x,div_y); 
%循环嵌入水印，Membedding()为封装的水印嵌入函数
for i=1:x 
    for j=1:y    
        if mean2(slope_block{i,j}) > mean_slope  %选择水印嵌入位置
        dem_block{i,j}=Membedding(wm,dem_block{i,j}); 
        end
    end
end
wm_dem=cell2mat(dem_block);  
%提取水印，extract()为封装的水印提取函数
w=cell(x,y); 
for i=1:x 
    for j=1:y 
      w{i,j}=extract(dem_block{i,j}); 
    end
end 
%显示嵌入前后的DEM数据以及提取水印
subplot(1,2,1); imshow(dem,[]); title('无水印DEM'); 
subplot(1,2,2); imshow(wm_dem,[]); title('有水印DEM'); 
w2=cell2mat(w);figure;imshow(w2); title('提取水印');

geotiffwrite('wm_dem.tif',wm_dem,R);%输出嵌入水印后的DEM
