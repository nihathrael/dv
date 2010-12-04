function [ pix ] = getpix(img,buftype,y,x)
  [sizey,sizex] = size(img(:,:,1));
  if x > 0 && y > 0 && x <= sizex && y <= sizey
    %zielpixel befindet sich innerhalb des bildes
    pix = img(y,x,:);
  else
    if buftype == 0
      pix = zeros(size(img(1,1,:)));
    elseif buftype == 1
      nx = mod(x,sizex) + 1;
      ny = mod(y,sizey) + 1;
      pix = img(ny,nx,:);
    elseif buftype == 2
      nx = x;
      ny = y;
      if x < 1
        nx = 1-x;
      end
      if y < 1
        ny = 1-y;
      end
      if x > sizex
        nx = 2*sizex - x;
      end
      if y > sizey
        ny = 2*sizey - y;
      end
      pix = img(ny,nx,:);
    end
  end
end
