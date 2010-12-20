function [ newimg ] = resizeH_SC(oldimg,tardim)
    % INPUT
    % img.............altes Bild (vor Skalierung) [0,255]<double>(:,:,:)
    % tardim..........Zieldimensionen(Vektor [ypixels xpixels]) <uint16>
    % OUTPUT
    % newimg..........skaliertes Bild [0,255]<double>(:,:,:)
    
    %oldimg um 90 Grad drehen und die Dimensionen vertauschen
    r = zeros(size(oldimg,2), size(oldimg,1), size(oldimg,3));
    r(:,:,1) = rot90(oldimg(:,:,1));
    r(:,:,2) = rot90(oldimg(:,:,2));
    r(:,:,3) = rot90(oldimg(:,:,3));
    
    r2 = resizeV_SC ( r, [tardim(2) tardim(1)] );
    
    %Ergebnis wieder um -90 Grad zurückdrehen
    newimg = zeros(tardim(1), tardim(2), 3 );
    newimg(:,:,1) = rot90(r2(:,:,1), -1);
    newimg(:,:,2) = rot90(r2(:,:,2), -1);
    newimg(:,:,3) = rot90(r2(:,:,3), -1);
end