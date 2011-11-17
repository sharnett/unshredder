function sean(picture, thickness)
if nargin<1, picture='cat1.jpg'; end;
if nargin<2, thickness = 32; end;
rgb = imread(picture);
height = size(rgb,1);
width = size(rgb,2)
width = width-mod(width,thickness);
rgb = rgb(:,1:width,:);
image(rgb); axis image;
pause;
n = width/thickness;

% shuffle
I = randperm(n);
J=[];
for i=1:length(I),
    J=[J (I(i)-1)*thickness+1:I(i)*thickness];
end
rgb = rgb(:,J,:);
figure;
image(rgb); axis image;
imwrite(rgb, 'test.tif','tif');
pause;

% reassemble
rgb2 = double([rgb(:,:,1); rgb(:,:,2); rgb(:,:,3)]);
rgbL = rgb2(:,1:thickness:width);
rgbR = rgb2(:,thickness:thickness:width);

c=zeros(n);
for i=1:n, c(i,:) = pdist2(rgbR(:,i)', rgbL'); end
a=[ones(1,n) zeros(1,n*(n-1))];
A=a;
for i=1:n-1,
    A = sparse([A; circshift(a, [0 i*n])]);
end
A=sparse([A;repmat(eye(n),1,n)]);
b=ones(2*n,1);

x=linprog(reshape(c,n^2,1),[],[],A,b,zeros(n^2,1),[]);
x=sparse(reshape(round(x),n,n));

[i,j,v] = find(c.*x); [y, K] = sort(v, 'descend'); 
figure;
for k=1:n,
    I = j(K(k));
    for i=2:n,
        I(i) = find(x(I(i-1),:));
    end
    if length(I) > length(unique(I)), 
        disp('subtour!'); 
    end
    J=[];
    for i=1:length(I),
        J=[J (I(i)-1)*thickness+1:I(i)*thickness];
    end
    image(rgb(:,J,:)); axis image;
    pause;
end
