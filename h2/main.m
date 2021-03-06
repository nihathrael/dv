disp('Loading image...');
img = double(imread('test.jpg'));

disp('Resizing...');
% jeweils kleiner und größer und verschiedene interpolation
sn = resizeLDV(img, [400 300], 'nearestneighbor');
bn = resizeLDV(img, [3000 1500], 'nearestneighbor');
sb = resizeLDV(img, [400 300], 'bilinear');
bb = resizeLDV(img, [3000 1500], 'bilinear');

imwrite(uint8(sn),'sn.bmp');
imwrite(uint8(bn),'bn.bmp');
imwrite(uint8(sb),'sb.bmp');
imwrite(uint8(bb),'bb.bmp');

disp('Chrominanz downscaling...');
ds422 = ds444to422(img);
imwrite(uint8(ds422),'ds422.bmp');
ds420 = ds444to420(img);
imwrite(uint8(ds420),'ds420.bmp');

disp('Chrominanz upscaling...');
us422 = us422to444(ds422);
imwrite(uint8(us422), 'us422.bmp');
us420 = us420to444(ds420);
imwrite(uint8(us420), 'us420.bmp');

disp('Transformationsmatrix parsen...');
m = afftrafomatrix('theta-25');
disp('Transformationsmatrix ist:');
disp(m);

disp('Affine Transformation anwenden...');
imgtrafd = afftrafo(img, m, 'nearestneighbor');

imwrite(uint8(imgtrafd), 'result.bmp');

disp('Done!');