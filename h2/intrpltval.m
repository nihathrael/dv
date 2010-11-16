function [ intrpltval ] = intrpltval(img,y,x,intrplttalg)
% INPUT
% img.............input Bild [0,255]<double>(:,:,:)
% y...............y Koordinate des zu interpolierenden Zielpixels <double>
% x...............x Koordinate des zu interpolierenden Zielpixels <double>
% intrpltalg......Interpolationsalgorithmus {'nearestneighbor','bilinear'}<string>
% OUTPUT
% intrpltval......interpolierter Farbwert [0,255]<double>(1,1,:)

if strcmp(intrplttalg, 'nearestneighbor')
    intrpltval = img(round(y),round(x),:);
elseif strcmp(intrplttalg, 'bilinear')
    % Randfälle
    if y < 1
        y=1;
    end
    if x < 1
        x=1;
    end
    
    ul = img(floor(y),floor(x),:);
    ur = img(floor(y),ceil(x),:);
    ll = img(ceil(y),floor(x),:);
    lr = img(ceil(y),ceil(x),:);
    
    wy = floor(y)-y;
    wx = floor(x)-x;
    
    l = (1-wy)*ul + wy*ll;
    r = (1-wy)*ur + wy*lr;
    
    intrpltval = (1-wx)*l + wx*r;
end
