img = double(imread('test.jpg'));
nn = intrpltval(img, 10.7, 15.3, 'nearestneighbor');
disp('Nearest Neighbor:')
disp(nn)

b = intrpltval(img, 10.7, 15.3, 'bilinear');
disp('Bilinear:');
disp(b)

b = intrpltval(img, 10.2, 15.9, 'bilinear');
disp('Bilinear:');
disp(b)