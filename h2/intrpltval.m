function [ interp_value ] = intrpltval(img, y, x, interpolate_algo)
    if strcmp(interpolate_algo, 'nearestneighbor')
        nearest_x = round(x);
        nearest_y = round(y);
        interp_value = img(nearest_y, nearest_x,:);
    elseif strcmp(interpolate_algo,'bilinear')
        % Normalisieren um später vereinfachte Formel für Bilineares
        % Filtern einsetzen zu können
        n_x = x-floor(x);
        n_y = y-floor(y);
        up_left     = img(floor(y), floor(x),:);
        up_right    = img(floor(y), ceil(x),:);
        down_left   = img(ceil(y),  floor(x),:);
        down_right  = img(ceil(y),  ceil(x),:);

        interp_value = up_left+(up_right-up_left)*n_x+(down_left-up_left)*n_y+(down_right-down_left-up_right+up_left)*n_y*n_x;
        
        %interp_value = (up_left*(1-n_x)*(1-n_y)+up_right*x*(1-n_y)+down_left*(1-n_x)*y+down_right*x*y);
        interp_value = round(interp_value);
    end
end

