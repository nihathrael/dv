function [ intrpltval ] = intrplt(img,y,x,intrplttalg)
% INPUT
% img.............input Bild [0,255]<double>(:,:,:)
% y...............y Koordinate des zu interpolierenden Zielpixels <double>
% x...............x Koordinate des zu interpolierenden Zielpixels <double>
% intrpltalg......Interpolationsalgorithmus {'nearestneighbor','bilinear'}<string>
% OUTPUT
% intrpltval......interpolierter Farbwert [0,255]<double>(1,1,:)

 if strcmp(intrplttalg, 'nearestneighbor')
        nearest_x = round(x);
        nearest_y = round(y);
        intrpltval = img(nearest_y, nearest_x,:);
    elseif strcmp(intrplttalg,'bilinear')
        % Normalisieren um später vereinfachte Formel für Bilineares
        % Filtern einsetzen zu können
        n_x = x-floor(x);
        n_y = y-floor(y);
        up_left     = img(floor(y), floor(x),:);
        up_right    = img(floor(y), ceil(x),:);
        down_left   = img(ceil(y),  floor(x),:);
        down_right  = img(ceil(y),  ceil(x),:);

        intrpltval = up_left+(up_right-up_left)*n_x+(down_left-up_left)*n_y+(down_right-down_left-up_right+up_left)*n_y*n_x;
        intrpltval = round(intrpltval);
    end
end
