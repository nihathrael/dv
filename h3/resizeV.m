function [ newimg ] = resizeV(oldimg,tardim)
% INPUT
% img.............altes Bild (vor Skalierung) [0,255]<double>(:,:,:)
% tardim..........Zieldimensionen(Vektor [ypixels xpixels]) <uint16>
% OUTPUT
% newimg..........skaliertes Bild [0,255]<double>(:,:,:)

assert(tardim(1) < size(oldimg, 1), 'Target dimension must be smaller than old dimension');

laplace = [0 -1 0; -1 4 -1; 0 -1 0]; % Laplacefilter
fltrdimg = fltr(oldimg, laplace, 'default'); % Bild filtern

deletecount = size(oldimg, 1) - tardim(1); % Anzahl zu löschender Zeilen

sumc = sum(fltrdimg,3); % Summe über alle Farben hinweg
sumy = sum(sumc,2); % Summe über alle Spalten hinweg

% Fülle leeren Vektor mit Indizes der zu löschenden Zeilen
delete = zeros(deletecount, 1);
for i=1:deletecount
    [y, k] = min(sumy);
    delete(i) = k;
    sumy(k) = realmax;
end

% Markiere nicht zu übernehmende Zeilen im Originalbild
for y=delete
    oldimg(y, 1, 1) = -1;
end

newimg = zeros(tardim(1), size(oldimg, 2), size(oldimg,3));

% Kopiere alle nicht markierten Spalten in das resultierende Bild
ynew = 1;
for yold=1:size(oldimg,1)
    if (oldimg(yold, 1, 1) ~= -1)
        newimg(ynew, :, :) = oldimg(yold, :, :);
        ynew = ynew + 1;
    end
end