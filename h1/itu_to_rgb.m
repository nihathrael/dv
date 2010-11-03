function [ rgbimg ] = itu_to_rgb(ituimg,ituversion)
    red = ituimg(:,:,3) + ituimg(:,:,1);
    blue = ituimg(:,:,2) + ituimg(:,:,1);
    if ituversion == 601
        green = (ituimg(:,:,1) - .299 * red - .114 * blue) / .587;
    else
        green = (ituimg(:,:,1) - .2126 * red - .0722 * blue) / .7152;
    end
    rgbimg = cat(3, red, green, blue);