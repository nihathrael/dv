clear

disp('Bild laden...');
img = double(imread('test.jpg'));

disp('Transformationsmatrix parsen...');
m = afftrafomatrix('theta10');
disp('Transformationsmatrix ist:');
disp(m);

disp('Affine Transformation anwenden...');
imgtrafd = afftrafo(img, m, 'nearestneighbor');

disp('Ergebnis in ''result.bmp'' speichern');
imwrite(uint8(imgtrafd), 'result.bmp');