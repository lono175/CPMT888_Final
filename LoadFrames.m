function Frames = GetFrames(dir, nFrame)


frame_dir = sprintf('.\%s', dir);
type = 'wave1'
for f_i=1:nFrame
  Frames(:,:,f_i) = rgb2gray(imread(sprintf('%s/%05d.png',frame_dir, f_i)));
  %normalize the frame
  Frames(:, :, :) = Frames(:, :, :) ./ 255;
end
