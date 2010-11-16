function [ trafomat ] = afftrafomatrix(trafostr)
% INPUT
% trafostr........String mit Transformationen <string>
% OUTPUT
% trafomat........affine 3x3 Transformationsmatrix <double>(3,3,1)

m = eye(3,3);

% Argumente in ein Char-Array bringen
argcell = textscan(trafostr,'%s');
arg = char(argcell{1,1});
argc = size(arg);

% Transformationen anwenden
for i=1:argc(1);
    trafo = strtrim(arg(i,:));
    s = size(trafo,2);
    assert(s>2, 'Wrong Input');
    temp = eye(3,3);
    if strcmp(trafo(1:2),'tu') % horizontal translation
        tu = str2double(trafo(3:s));
        temp(3,1) = tu;
    elseif strcmp(trafo(1:2),'tv') % vertical translation
        tv = str2double(trafo(3:s));
        temp(3,2) = tv;
    elseif s>4 && strcmp(trafo(1:5),'theta') % translation
        theta = (str2double(trafo(6:s))/360)*2*pi;
        temp(1:2,1:2) = [cos(theta) sin(theta); -sin(theta) cos(theta)];
    elseif strcmp(trafo(1:2),'su') % horizontal scaling
        su = str2double(trafo(3:s));
        temp(1,1) = su;
    elseif strcmp(trafo(1:2),'sv') % vertical scaling
        sv = str2double(trafo(3:s));
        temp(2,2) = sv;
    elseif strcmp(trafo(1:2),'hu') % horizontal shear
        hu = str2double(trafo(3:s));
        temp(1,2) = hu;
    elseif strcmp(trafo(1:2),'hv') % vertical shear
        hv = str2double(trafo(3:s));
        temp(2,1) = hv;
    end
    m = m * temp;
end

trafomat = m;
