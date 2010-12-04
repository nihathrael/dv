%INPUT
%img.............input Bild [0,255]<double>(:,:,:)
%fltrkernel......Filterkernel <double>(:,:,1)
%buftype.........Buffer-Art {'default','copy','mirror'}<string>
%OUTPUT
%fltrdimg........gefiltertes Bild [0,255]<double>(:,:,:)
function [ fltrdimg ] = fltr(img,fltrkernel,buftype)
  [sizey,sizex,sizec] = size(img);
  [sizefy,sizefx] = size(fltrkernel);

  randy = floor(sizefy/2);
  randx = floor(sizefx/2);

  img2 = zeros ( sizey + 2 * randy, sizex + 2 * randx, 3 );
  img2 ( (randy+1):randy+sizey, (randx+1):randx+sizex, : ) = img(:,:,:);

  fltrdimg = zeros ( sizey, sizex, 3 );

  if strcmp(buftype, 'default')
    %nix zu machen
  elseif strcmp(buftype, 'copy')
    %oben
    img2 ( 1 : randy , randx+1 : randx+sizex , : ) = img ( 1:randy, 1:sizex, :);
    %links
    img2 ( randy+1 : randy+sizey , 1 : randx , : ) = img ( 1:sizey, 1:randx, :);
    %unten
    img2 ( randy+sizey+1 : 2*randy+sizey , randx+1 : randx+sizex, : ) = img ( sizey-randy+1:sizey , 1:sizex , :);
    %rechts
    img2 ( randy+1 : randy+sizey , randx+sizex+1 : 2*randx+sizex, : ) = img ( 1:sizey , sizex-randx+1:sizex , :);
    %links oben
    img2 ( 1 : randy , 1 : randx , : ) = img ( 1:randy, 1:randx, :);
    %rechts oben
    img2 ( 1 : randy , randx+sizex+1 : 2*randx+sizex , : ) = img ( 1:randy, sizex-randx+1:sizex, :);
    %links unten
    img2 ( randy+sizey+1 : 2*randy+sizey , 1 : randx , : ) = img ( sizey-randy+1:sizey, 1:randx, :);
    %rechts unten
    img2 ( randy+sizey+1 : 2*randy+sizey , randx+sizex+1 : 2*randx+sizex , : ) = img ( sizey-randy+1:sizey , sizex-randx+1:sizex, :);
  elseif strcmp(buftype, 'mirror')
    %oben
    img2 ( 1:randy, randx+1 : randx+sizex, : ) = img ( randy:-1:1, 1:sizex, : );
    %links
    img2 ( randy+1 : randy+sizey , 1 : randx , : ) = img ( 1:sizey, randx:-1:1, :);
    %unten
    img2 ( randy+sizey+1 : 2*randy+sizey , randx+1 : randx+sizex, : ) = img ( sizey:-1:sizey-randy+1 , 1:sizex , :);
    %rechts
    img2 ( randy+1 : randy+sizey , randx+sizex+1 : 2*randx+sizex, : ) = img ( 1:sizey , sizex:-1:sizex-randx+1 , :);
    %links oben
    img2 ( 1 : randy , 1 : randx , : ) = img ( randy:-1:1, randx:-1:1, :);
    %rechts oben
    img2 ( 1 : randy , randx+sizex+1 : 2*randx+sizex , : ) = img ( randy:-1:1, sizex:-1:sizex-randx+1, :);
    %links unten
    img2 ( randy+sizey+1 : 2*randy+sizey , 1 : randx , : ) = img ( sizey:-1:sizey-randy+1, randx:-1:1, :);
    %rechts unten
    img2 ( randy+sizey+1 : 2*randy+sizey , randx+sizex+1 : 2*randx+sizex , : ) = img ( sizey:-1:sizey-randy+1 , sizex:-1:sizex-randx+1, :);
  end

  %imwrite(uint8(img2),'f2.bmp');

  fltkernel2 = zeros ( sizefy, sizefx, sizec );
  for c=1:sizec
    fltkernel2(:,:,c) = fltkernel2(:,:,c) + fltrkernel;
  end

  for y=1 : sizey
    for x=1 : sizex
      tmp = zeros(sizefy,sizefx,sizec) + img2( (y):(y+2*randy) , (x):(x+2*randx) , : );
      tmp = tmp .* fltkernel2;
      sum1 = sum(tmp,1);
      w = sum(sum1,2);
      fltrdimg(y,x,:) = w;
    end
  end
end
