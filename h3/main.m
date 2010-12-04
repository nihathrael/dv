disp('Loading image...');
img = double(imread('bild.bmp'));

disp('Filtering...');
k = [ 0, 0.2, 0; 0.2, 0.2, 0.2; 0, 0.2, 0 ];
k
imgf = fltr ( img, k, 'mirror' );
imwrite(uint8(imgf),'f.bmp');

disp('Done!');
