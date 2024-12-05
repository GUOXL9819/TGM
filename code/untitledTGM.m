clc,clear
tic
[im,R] =geotiffread('D:\software\MATLAB\work\work1\zhongguo_DYW\LC08_121044_20230219.tif');
[outputArg1,outputArg2]=TGM_English(im,1);

figure;
imshow(im);
clim([min(im ,[],'all') max(im,[],'all')]);
colorbar();
mymap=[1 1 1;parula];
colormap(mymap);
hold on
% 1st-level TR boundary line is red
% 2nd-level TR boundary line is blue
% 3rd-level TR boundary line is pink
% 4th-level TR boundary line is black
[xx, yy] = meshgrid(1:size(im, 2), 1:size(im, 1));
[c1,~]=contour3(xx,yy,outputArg2,[1 2],'r');
[c2,~]=contour3(xx,yy,outputArg2,[2 3],'b');
[c3,~]=contour3(xx,yy,outputArg2,[3 4],'m');
[c4,~]=contour3(xx,yy,outputArg2,[4 100],'k');
N=histcounts(outputArg2,[1 2 3 4 100]);
Area=N*R.CellExtentInLatitude*111319.49*R.CellExtentInLongitude*111319.49*cosd(mean(R.LatitudeLimits))/1000000;
fprintf(['The background temperature calculated from the image is: %.2f%sC\n', ...
    '1st-level TR: %.2f km²\n', ...
    '2nd-level TR: %.2f km²\n', ...
    '3rd-level TR: %.2f km²\n', ...
    '4th-level TR: %.2f km²\n'], outputArg1, char(176), Area(1), Area(2), Area(3), Area(4));