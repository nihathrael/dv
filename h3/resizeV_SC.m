function [ newimg ] = resizeV_SC(oldimg,tardim)
    % INPUT
    % img.............altes Bild (vor Skalierung) [0,255]<double>(:,:,:)
    % tardim..........Zieldimensionen(Vektor [ypixels xpixels]) <uint16>
    % OUTPUT
    % newimg..........skaliertes Bild [0,255]<double>(:,:,:)


    % Filter using laplace, use as energy function for now
    laplace = [0 -1 0; -1 4 -1; 0 -1 0]; % Laplacefilter
    newimg = oldimg;
    fltrdimg = fltr(oldimg, laplace, 'default'); % Bild filtern
    fltrdimg = sum(fltrdimg, 3); % Sum up for one energy function!
    
    
    % create matrix for backtracking seams
    m = zeros(size(fltrdimg, 1), size(fltrdimg, 2));

    
    
    for i=1:size(fltrdimg, 1)
      for b=1:size(fltrdimg, 2)
          if b==1
              m(i,b) = 0; % just add fltrdimg(i,b) later
          elseif i==1
             m(i,b) = min([m(i+1, b-1) m(i, b-1)]);
          elseif i==size(fltrdimg, 1)
              m(i,b) = min([m(i, b-1) m(i-1, b-1)]);
          else
               m(i,b) = min([m(i+1, b-1) m(i, b-1) m(i-1, b-1)]);
          end
          m(i,b) = m(i,b) + fltrdimg(i,b);
      end
    end
    
    deletecount = size(oldimg, 1) - tardim(1); % Anzahl zu löschender Spalte
    for d=1:deletecount
        fprintf('Searching for seam... (%d/%d)\n', d, deletecount)
        % find smallest end to backtrack
        b = size(fltrdimg, 2);
        minx = 1;
        for i=1:size(m, 1)
            if m(i,b) < m(minx,b)
                minx = i;
            end
        end
        % Find seam
        seam = backtrack([minx, b], [], m);

        % Remove seam -> slow as hell...
        tmpimg = zeros(size(newimg, 1)-1, size(newimg, 2),3);
        tmpm = zeros(size(m, 1)-1, size(m, 2));
        fprintf('- Removing seam... (%d/%d)\n', d, deletecount)
        for entry = seam
            x = entry{1}(1);
            y = entry{1}(2);
            
            tmp = newimg(:,y,1);
            tmp(x) = [];
            tmpimg(:,y,1) = tmp;
            
            tmp = newimg(:,y,2);
            tmp(x) = [];
            tmpimg(:,y,2) = tmp;
            
            tmp = newimg(:,y,3);
            tmp(x) = [];
            tmpimg(:,y,3) = tmp;
            
            tmp2 = m(:,y,:);
            tmp2(x) = [];
            tmpm(:,y,:) = tmp2;
            
        end
        newimg = tmpimg;
        m = tmpm;
    end

end

function [path] = backtrack (start, path, m)
    if size(path) == 0
        path = {start};
    end
    
    path = [path {start}];
    if start(2) == 1
        return
    end
    
    next = [start(1) start(2)-1];
    minval = m(start(1), start(2)-1);
        
    if start(1) > 1 && m(start(1)-1, start(2)-1) < minval
        next = [start(1)-1 start(2)-1];
        minval = m(start(1)-1, start(2)-1);
    end
    if start(1) < size(m, 1) && m(start(1)+1, start(2)-1) < minval
        next = [start(1)+1 start(2)-1];
    end
    path = [path backtrack(next, path, m)];
end
