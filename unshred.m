function rgb = unshred(rgb, thickness)

height = size(rgb,1);
width = size(rgb,2);
n = width/thickness;
rgb2 = double([rgb(:,:,1); rgb(:,:,2); rgb(:,:,3)]);
rgbL = rgb2(:,1:thickness:width);
rgbR = rgb2(:,thickness:thickness:width);

% build the linear optimization problem
c=zeros(n);
for i=1:n, c(i,:) = pdist2(rgbR(:,i)', rgbL'); end
u = speye(n); v = ones(1,n);
A=[kron(u,v); kron(v,u)];
b=ones(2*n,1);

% solve it
x=linprog(reshape(c,n^2,1),[],[],A,b,zeros(n^2,1),[]);
x=sparse(reshape(round(x),n,n));

% solution is a loop. need to decide where to cut the loop
% start with the connection with greatest cost, and descend if necessary
[i,j,v] = find(c.*x); [y, K] = sort(v, 'descend'); 
for k=1:n,
    I = j(K(k));
    for i=2:n, I(i) = find(x(I(i-1),:)); end
    if length(I) > length(unique(I)), disp('subtour!'); end
    J=[];
    for i=1:length(I),
        J=[J (I(i)-1)*thickness+1:I(i)*thickness];
    end
    image(rgb(:,J,:)); axis image;
    msg = input('is this acceptable? (y/n) ', 's');
    if msg=='y' | msg=='Y', 
        rgb = rgb(:,J,:); 
        break; 
    end 
end
