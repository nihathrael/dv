function [ img ] = demosaic(imgbayer)
[h,w] = size(imgbayer);
rmask=zeros(h,w);
rmask(1:2:h,1:2:w)=1;
gmask=zeros(h,w);
gmask(1:2:h,2:2:w)=1;
gmask(2:2:h,1:2:w)=1;
bmask=zeros(h,w);
bmask(2:2:h,2:2:w)=1;
r=zeros(h,w)+imgbayer.*rmask;
g=zeros(h,w)+imgbayer.*gmask;
b=zeros(h,w)+imgbayer.*bmask;
for y=1:2:h
    for x=2:2:w
        if x==2
            r(y,x)=imgbayer(y,x+1);
        elseif x==w
            r(y,x)=imgbayer(y,x-1);
        else
            r(y,x)=(imgbayer(y,x-1)+imgbayer(y,x+1)) / 2;
        end
    end
end
for y=2:2:h
    for x=1:2:w
        if x==1
            b(y,x)=imgbayer(y,x+1);
        elseif x==w
            b(y,x)=imgbayer(y,x-1);
        else
            b(y,x)=(imgbayer(y,x-1)+imgbayer(y,x+1)) / 2;
        end
    end
end

img=cat(3,r,g,b);
