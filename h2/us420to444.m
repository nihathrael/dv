function [ img444 ] = us422to444(img422)
% INPUT
% img422..........YCbCr/Y'CbCr 4:2:2 Bild [0,255]<double>(:,:,:)
% OUTPUT
% img444..........YCbCr/Y'CbCr 4:4:4 Bild [0,255]<double>(:,:,:)

img444 = img422;
img444(:,:,2:3) = resizeLDV(img422(1:size(img422,1)/2, 1:size(img422,2)/2, 2:3), ...
    [size(img422,1) size(img422,2)], 'nearestneighbor');