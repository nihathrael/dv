function [ img422 ] = ds444to422(img444)
% INPUT
% img444..........YCbCr/Y'CbCr 4:4:4 Bild [0,255]<double>(:,:,:)
% OUTPUT
% img422..........YCbCr/Y'CbCr 4:2:2 Bild [0,255]<double>(:,:,:)

y = img444(:,:,1);
cbcr = resizeLDV(img444(:,:,2:3), [size(img444,1) size(img444,2)/2], 'nearestneighbor');

img422 = zeros(size(img444));
img422(:,:,1) = y;
img422(:,:,2:3) = [cbcr, zeros(size(cbcr))];