%INPUT
%img.............input Bild [0,255]<double>(:,:,:)
%fltrkernel......Filterkernel <double>(:,:,1)
%buftype.........Buffer-Art {'default','copy','mirror'}<string>
%OUTPUT
%fltrdimg........gefiltertes Bild [0,255]<double>(:,:,:)
function [ fltrdimg ] = fltr(img,fltrkernel,buftype)
  [sizey,sizex] = size(img(:,:,1));
  [sizefy,sizefx] = size(fltrkernel);

  fltrdimg = zeros ( sizey, sizex, 3 );

  buftypeint = 0;
  if strcmp(buftype, 'default')
    buftypeint = 0;
  elseif strcmp(buftype, 'copy')
    buftypeint = 1;
  elseif strcmp(buftype, 'mirror')
    buftypeint = 2;
  end

  for x=1 : size(img,2)
    x
    for y=1: size(img,1)
      for fx=1 : size(fltrkernel,2)
        for fy=1 : size(fltrkernel,1)
          w = (fltrkernel(fy,fx) * getpix ( img(:,:,:), buftypeint, y + fy - 1 - floor(sizefy/2), x + fx - 1 - floor(sizefx/2) ));
          fltrdimg(y,x,:) = fltrdimg(y,x,:) + w;
        end
      end
    end
  end
end
