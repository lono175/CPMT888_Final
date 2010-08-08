function scaleFrames = GetScaleFrames()
clipSize = [80,40];

%get the foreground image
load classification_masks
mask = original_masks.denis_wave1;

frame_dir = 'D:\CPMT888\CPMT888_Final\wave1\wave1'
nFrame = size(mask, 3)
index = 1
type = 'wave1'



box = [];
for f_i=1:nFrame
    tmp = regionprops(mask(:, :, f_i), 'boundingbox')
    center = regionprops(mask(:, :, f_i), 'centroid');
    box(f_i, :) = [tmp.BoundingBox round(center.Centroid)];
end

diffX = [box(:, 3) - box(:, 5) + box(:, 1); box(:, 1) - box(:, 5)];
diffY = [box(:, 4) - box(:, 6) + box(:, 2); box(:, 2) - box(:, 6)];
maxHalfWidth = max(abs(diffX));
maxHalfHeight = max(abs(diffY));

Frames = [];
clipFrames = [];
for f_i=1:nFrame
  Frames(:,:,f_i) = rgb2gray(imread(sprintf('%s/%s%05d.png',frame_dir,type, f_i)));
  %normalize the frame
  Frames(:, :, :) = Frames(:, :, :) ./ 255;

  %Frames(:,:,f_i) = (imread(sprintf('%s/%s%05d.png',frame_dir,type, f_i)));
  %center = regionprops(mask(:, :, f_i), 'centroid');
  %center = center.Centroid;
  startX = round(box(f_i, 5) - maxHalfWidth);
  endX = round(box(f_i, 5) + maxHalfWidth);
  startY = round(box(f_i, 6) - maxHalfHeight);
  endY = round(box(f_i, 6) + maxHalfHeight);
  clipFrames(:, :, f_i) = Frames(startY:endY, startX:endX, f_i);
end

%sacle it to 80X40
for f_i=1:nFrame
    scaleFrames(:, :, f_i) = imresize(clipFrames(:, :, f_i), clipSize);
end
