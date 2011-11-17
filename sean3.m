function thickness = sean3(picture)

rgb = imread(picture);
rgb2 = double([rgb(:,:,1); rgb(:,:,2); rgb(:,:,3)]);
height = size(rgb,1);
width = size(rgb,2);
factors = width ./ [2:width-1];
factors = factors(factors==floor(factors));

% iterate through list of factors of the width
% determine which candidate slice thickness leads to maximum total distance
d = zeros(size(factors));
for i=1:length(factors),
    thickness = factors(i);
    n = width/thickness;
    rgbL = rgb2(:,1:thickness:width);
    rgbR = rgb2(:,thickness:thickness:width);
    for j=1:n-1,
        d(i) = d(i) + norm(rgbR(:,j)-rgbL(:,j+1));
    end
    d(i) = d(i)/(n-1);
end
[factors' d']
[y, i] = max(d);
thickness = factors(i);
