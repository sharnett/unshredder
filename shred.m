function rgb = shred(rgb, thickness)

height = size(rgb,1);
width = size(rgb,2);
width = width-mod(width,thickness);
rgb = rgb(:,1:width,:);
n = width/thickness;

I = randperm(n);
J=zeros(width,1);
for i=1:length(I),
    J([(i-1)*thickness+1:i*thickness]) = (I(i)-1)*thickness+1:I(i)*thickness;
end
rgb = rgb(:,J,:);
