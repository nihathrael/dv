function [ newimg ] = resizeH(oldimg,tardim)
% INPUT
% img.............altes Bild (vor Skalierung) [0,255]<double>(:,:,:)
% tardim..........Zieldimensionen(Vektor [ypixels xpixels]) <uint16>
% OUTPUT
% newimg..........skaliertes Bild [0,255]<double>(:,:,:)

assert(tardim(2) < size(oldimg, 2), 'Target dimension must be smaller than old dimension');

laplace = [0 -1 0; -1 4 -1; 0 -1 0]; % Laplacefilter
fltrdimg = fltr(oldimg, laplace, 'default'); % Bild filtern

deletecount = size(oldimg, 2) - tardim(2); % Anzahl zu löschender Spalten

sumc = sum(fltrdimg,3); % Summe über alle Farben hinweg
sumx = sum(sumc); % Summe über alle Spalten hinweg

% Fülle leeren Vektor mit Indizes der zu löschenden Spalten
delete = zeros(deletecount, 1);
for i=1:deletecount
    [y, k] = min(sumx);
    delete(i) = k;
    sumx(k) = realmax;
end

% Markiere nicht zu übernehmende Spalten im Originalbild
for x=delete
    oldimg(1, x, 1) = -1;
end

newimg = zeros(size(oldimg, 1), tardim(2), size(oldimg,3));

% Kopiere alle nicht markierten Spalten in das resultierende Bild
xnew = 1;
for xold=1:size(oldimg,2)
    if (oldimg(1, xold, 1) ~= -1)
        newimg(:, xnew, :) = oldimg(:, xold, :);
        xnew = xnew + 1;
    end
end