function [ ituimg ] = rgb_to_itu(rgbimg,ituversion)
    if ituversion == 601
        y = .299 * rgbimg(:,:,1) + .587 * rgbimg(:,:,2) + .114 * rgbimg(:,:,3);
    else
        y = .2126 * rgbimg(:,:,1) + .7152 * rgbimg(:,:,2) + .0722 * rgbimg(:,:,3);
    end
    ituimg = cat(3, y, rgbimg(:,:,3) - y, rgbimg(:,:,1) - y);