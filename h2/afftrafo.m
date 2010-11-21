function [ imgtrafd ] = afftrafo(img,trafomat,intrpltalg)
% INPUT
% img.............input Bild [0,255]<double>(:,:,:)
% trafomat........Transformationsmatrix <double>(3,3,1)
% intrpltalg......Interpolationsalgorithmus {'nearestneighbor','bilinear'}<string>
% OUTPUT
% imgtrafd........transformiertes Bild [0,255]<double>(:,:,:)

% Bildgröße des Zielbildes herausfinden anhand der transformierten Eckpixel
% des Urbildes
xmax = realmin;
ymax = realmin;
xmin = realmax;
ymin = realmax;
for v= 1 : size(img,1)-1 : size(img,1)
    for u= 1 : size(img,2)-1 : size(img,2)
        bild = [u v 1] * trafomat; 
        if bild(1) > xmax
            xmax = bild(1);
        end
        if bild(2) > ymax
            ymax = bild(2);
        end
        if bild(1) < xmin
            xmin = bild(1);
        end
        if bild(2) < ymin
            ymin = bild(2);
        end
    end
end

xmax = ceil(xmax);
ymax = ceil(ymax);
xmin = floor(xmin);
ymin = floor(ymin);

imgtrafd = zeros(ymax-ymin, xmax-xmin, 3);

% Transformationsmatrix invertieren
a = trafomat;
invtrafomat = (1/(a(1,1)*a(2,2) - a(1,2)*a(2,1))) * ...
    [ a(2,2) -a(1,2) 0; ...
     -a(2,1)  a(1,1) 0; ...
      a(2,1)*a(3,2)-a(3,1)*a(2,2) ...
      a(3,1)*a(1,2)-a(1,1)*a(3,2) ...
      a(1,1)*a(2,2)-a(1,2)*a(2,1) ];

% Zielbild rückwärts transformieren, dazu alle Pixel des transformierten
% Bildes abgrasen und schauen ob das Urbild getroffen wird. Falls ja
% interpolieren. Bild um den Offset versetzt speichern, der sich durch die
% Versetzung ergibt.
for y=1:size(imgtrafd,1)
    for x=1:size(imgtrafd,2)
        urbild = [x+xmin y+ymin 1] * invtrafomat;
        
        % Falls das Urbild nicht getroffen wird, mache Pixel grün
        if urbild(1) < 1 || urbild(1) > size(img,2) || ...
                urbild(2) < 1 || urbild(2) > size(img,1)
            imgtrafd(y,x,:) = [0 255 0];
            
        % Falls das Urbild getroffen wird, interpoliere Pixel
        else
            imgtrafd(y,x,:) = intrplt(img, urbild(2), urbild(1), intrpltalg);
        end
    end
end