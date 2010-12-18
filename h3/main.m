disp('Loading image...');
img = double(imread('bild.bmp'));

disp('Filtering...');
k = [ 0, 0.2, 0; 0.2, 0.2, 0.2; 0, 0.2, 0 ];

imgf = fltr ( img, k, 'copy' );
imwrite(uint8(imgf),'f.bmp');

disp('Done!');

disp('Resizing horizontally...');
imgresH = resizeH(img, [390 500]);
imwrite(uint8(imgresH), 'rH.bmp');
disp('Done!');

disp('Resizing vertically...');
imgresV = resizeV(img, [300 600]);
imwrite(uint8(imgresV), 'rV.bmp');
disp('Done!');