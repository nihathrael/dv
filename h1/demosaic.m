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
for y=1:2:h         % Von oben jede 2 Zeile
    for x=2:2:w     % Ab der 2. Spalte jede 2. Spalte
        if x==2
            r(y,x)=imgbayer(y,x+1);
        elseif x==w
            r(y,x)=imgbayer(y,x-1);
        else
            r(y,x)=(imgbayer(y,x-1)+imgbayer(y,x+1)) / 2;
        end
    end
end
for y=2:2:h         % Ab der 2. Zeile jede 2. Zeile
    for x=1:1:w     % Alle spalten
        if y+1 <= h
            r(y,x)=(r(y-1,x)+r(y+1,x))/2;
        else
            r(y,x)=r(y-1,x);
        end
    end
end

for y=2:2:h         % Ab der 2. Zeile jede 2. Zeile
    for x=1:2:w     % Ab der 1. Spalte jede 2. Spalte
        if x==1
            b(y,x)=imgbayer(y,x+1);
        elseif x==w
            b(y,x)=imgbayer(y,x-1);
        else
            b(y,x)=(imgbayer(y,x-1)+imgbayer(y,x+1)) / 2;
        end
    end
end

for y=1:2:h         % Ab der 1 Zeilen jede 2. Zeile
    for x=1:1:w
        if y-1 > 0
            b(y,x)=(b(y-1,x)+b(y+1,x))/2;
        else
            b(y,x)=b(y+1,x);
        end
    end
end

% Grün ungerade zeilen
for y=1:2:h
    for x=1:2:w
        if x==1
            g(y,x)=g(y,x+1);
        elseif x==w
            g(y,x)=g(y,x-1);
        else
            g(y,x)=(g(y,x-1)+g(y,x+1))/2;
        end
    end
end
% gründ gerade zeilen
for y=2:2:h
    for x=2:2:w
        if x==w
            g(y,x)=g(y,x-1);
        else
            g(y,x)=(g(y,x-1)+g(y,x+1))/2;
        end
    end
end
img=cat(3,r,g,b);
