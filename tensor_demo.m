% Frames is sequence of frames, N-by-M-by-T

%try to jitter the data(reflection, slightly shift)

frame_dir = 'D:\CPMT888\Final';
nFrame = 3
index = 1
%type = 'move'
%type = 'still'
type = 'nmove'
%type = 'skew'

Frames = [];
for f_i=1:nFrame
  Frames(:,:,f_i) = rgb2gray(imread(sprintf('%s/%s%01d.png', frame_dir, type, f_i)));
end

%normalize the frame
Frames(:, :, :) = Frames(:, :, :) ./ 255;
bSize = [3, 3, 1]; %block size

G = [];

x = 5
%y = 5
t = 2

i = 1;
for y = 4:6
    block = Frames(y-bSize(1):y+bSize(1), x-bSize(2):x+bSize(2), t-bSize(3):t+bSize(3));
    [Ix,Iy,It] = partial_derivative_3D(block);
    G(i, :) = [Ix, Iy, It];
    i = i + 1;
end

%tensor = partial_derivative_to_structure_tensor_form([Ix, Iy, It])
%G
M = G'*G
GetCorr(G, G)
