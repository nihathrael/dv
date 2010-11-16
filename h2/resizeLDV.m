function [ newimg ] = resizeLDV(oldimg,tardim,intrpltalg)
% INPUT
% img.............altes Bild (vor Skalierung) [0,255]<double>(:,:,:)
% tardim..........Zieldimensionen(Vektor [ypixels xpixels]) <uint16>
% intrpltalg......Interpolationsalgorithmus {'nearestneighbor','bilinear'}<string>
% OUTPUT
% scimg..........skaliertes Bild [0,255]<double>(:,:,:)

newimg = zeros([tardim size(oldimg,3)]);

for y=1:tardim(1)
    for x=1:tardim(2)
        newimg(y,x,:) = intrpltval(oldimg, y*size(oldimg,1)/tardim(1), ...
            x*size(oldimg,2)/tardim(2) , intrpltalg);
    end
end