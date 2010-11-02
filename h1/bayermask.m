function [imgbayer] = bayermask(img)
r=img(:,:,1);
g=img(:,:,2);
b=img(:,:,3);

[h,w] = size(r);
rmask=zeros(h,w);
rmask(1:2:h,1:2:w)=1;
gmask=zeros(h,w);
gmask(1:2:h,2:2:w)=1;
gmask(2:2:h,1:2:w)=1;
bmask=zeros(h,w);
bmask(2:2:h,2:2:w)=1;

imgbayer=r.*rmask + g.*gmask + b.*bmask;
