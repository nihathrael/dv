function [ img ] = demosaic(imgbayer)
    x = size(imgbayer, 2) / 2;
    y = size(imgbayer, 1) / 2;
    
    f1 = [.25 0 .25; 0 0 0; .25 0 .25];
    f2 = [0 .25 0; .25 0 .25; 0 .25 0];
    
    red = imgbayer .* repmat([1 0; 0 0], y, x);
    red1 = filter2(red, f1, 'full');
    red2 = filter2(red1, f2, 'full');
    red = red + red1(size(imgbayer, 1), size(imgbayer, 2)) + red2(size(imgbayer, 1), size(imgbayer, 2));
    
    green = imgbayer .* repmat([0 1; 1 0], y, x);
    green1 = filter2(green, f2, 'full');
    green = green + green1(size(imgbayer, 1), size(imgbayer, 2));
    
    blue = imgbayer .* repmat([0 0; 0 1], y, x);
    blue1 = filter2(blue, f1, 'full');
    blue2 = filter2(blue1, f2, 'full');
    blue = blue + blue1(size(imgbayer, 1), size(imgbayer, 2)) + blue2(size(imgbayer, 1), size(imgbayer, 2));
    
    img = cat(3, red, green, blue);