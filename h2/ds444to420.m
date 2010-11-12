function [ img420 ] = ds444to420(img444)
% INPUT
% img444..........YCbCr/Y'CbCr 4:4:4 Bild [0,255]<double>(:,:,:)
% OUTPUT
% img420..........YCbCr/Y'CbCr 4:2:2 Bild [0,255]<double>(:,:,:)

y = img444(:,:,1);
cbcr = resizeLDV(img444(:,:,2:3), [size(img444,1)/2 size(img444,2)/2], 'nearestneighbor');

img420 = zeros(size(img444));
img420(:,:,1) = y;
img420(:,:,2:3) = [cbcr, zeros(size(cbcr)); zeros(size(cbcr)), zeros(size(cbcr))];