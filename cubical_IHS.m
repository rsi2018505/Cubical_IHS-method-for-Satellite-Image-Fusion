paths = ['ihs_pansharp:', 'common:', 'metrics:', 'sdata:'];
addpath(paths);
 
%[file, pathname] = uigetfile('*.jpg','Select the PAN Image ');cd(pathname);
panimage=imread('cartopan.jpg');
%[file, pathname] = uigetfile('*.jpg','Select the Multispectral Image ');cd(pathname);
%b=imread('');

%WHEN USING LANDSAT WITH SENTINEL, NO NEED TO RESIZE

RR=imread('sen2red.jpg');
GG=imread('sen2green.jpg');
BB=imread('sen2blue.jpg');
% 
% % SENTINAL RESIZED TO CARTO
RR = imresize(RR, size(panimage));
GG = imresize(GG, size(panimage));
BB = imresize(BB, size(panimage)); 

[r,c]=size(RR);
image = zeros([r,c,3]);
image(:,:,1)=RR;
image(:,:,2)=GG;
image(:,:,3)=BB;
image=double(image)/255;
%figure, imshow(image)
panimage = double(panimage)/255;

R=image(:,:,1);
G=image(:,:,2);
B=image(:,:,3);

size(image);
size(panimage);

outputimage = solve_pansharp(image,panimage);

%imwrite(outputimage,'output_image/cubicallandsat.jpg');

RMSEvalue = RMSE(outputimage,image);
disp(RMSEvalue);


corr = CORR(outputimage(:,:,1),R(:,:,1))
corr = CORR(outputimage(:,:,2),G(:,:,1))
corr = CORR(outputimage(:,:,3),B(:,:,1))
    
% entropy = ENTROPY(outputimage(:,:,1))
% entropy = ENTROPY(outputimage(:,:,2))
% entropy = ENTROPY(outputimage(:,:,3))
%     
% ergas = ERGAS(outputimage,image,0.5)
% psnr = PSNR(outputimage,image)
% sam = SAM(outputimage,image)
% sd = SD(outputimage)

rmpath(paths);

disp("reached end");

