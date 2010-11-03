img = double(imread('test.jpg'));
subplot(3, 2, 1);
imshow(uint8(img));

img = bayermask(img);
subplot(3, 2, 3);
imshow(uint8(img));

img = demosaic(img);
subplot(3, 2, 4);
imshow(uint8(img));

subplot(3, 2, 5);
imshow(uint8(rgb_to_itu(img, 601)));

subplot(3, 2, 6);
imshow(uint8(rgb_to_itu(img, 709)));