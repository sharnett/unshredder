function sean(picture, thickness)

close all;

% load
if nargin<1, picture='cat1.jpg'; end;
if nargin<2, thickness = 32; end;
rgb = imread(picture);
image(rgb); axis image;
disp('here is the original image. hit enter to continue');
pause;

% shred
rgb = shred(rgb, thickness);
image(rgb); axis image;
fprintf(1, 'image has been shredded with slices %d pixels thick\n', thickness);
disp('hit enter to continue');
pause;

% detect slice thickness
thickness = detectthickness(rgb);
fprintf(1, 'thickness is %d\n', thickness);

% unshred
rbg = unshred(rgb, thickness);
close all;
