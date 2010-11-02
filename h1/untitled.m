img = double(imread('bild.bmp'));
img2=bayermask(img);
imwrite(uint8(img2),'bild2.bmp');
img3=demosaic(img2);
imwrite(uint8(img3),'bild3.bmp');
