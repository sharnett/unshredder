function thickness = detectthickness(rgb)

height = size(rgb,1);
width = size(rgb,2);
rgb2 = double([rgb(:,:,1); rgb(:,:,2); rgb(:,:,3)]);
a = zeros(width-1);

for j=1:width-1, a(j) = norm(rgb2(:,j)-rgb2(:,j+1)); end
[a, lags] = xcorr(diff(a)); 
I=width:length(a);
[m,i] = max(a(I));
thickness = lags(I(i));
