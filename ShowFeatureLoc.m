%comparision with recognize action at a distance
oriMask = original_masks;
actionType = 'denis_wave1';

bSize = [2, 2, 2]; %half block size to compute the derivative
pSize = [2, 2, 2]; %half ST patch size 
clipSize = [80,40];

maskStr = sprintf('mask=oriMask.%s;', actionType);
eval(maskStr);
frame_dir = actionType;

nFrame = size(mask, 3);
Frames = LoadFrames(frame_dir, nFrame);
[scaleFrames boxSize]= GetScaleFrames(Frames, mask, clipSize);

%convert the scale images into rbg
for i = 1:size(scaleFrames, 3)
    colorFrames(:, :, :, i) = gray2rgb(scaleFrames(:, :, i));
end
featureNum = find(model.w ~= 0) - 1 %make it starting from 0, so mod will work
frameNum = floor(featureNum/size(kernelG, 1)/size(kernelG, 2)) + 1;
rowNum = floor(mod(featureNum, size(kernelG, 1)*size(kernelG, 2))/size(kernelG, 2)) + 1;
colNum = mod(mod(featureNum, size(kernelG, 1)*size(kernelG, 2)), size(kernelG, 2)) + 1;

%temporalOffset = bSize(3) + pSize(3);
%for t = 1 : length(frameNum)
    %img = colorFrames(:, :, :, frameNum(t)+temporalOffset);
    %patchRange = [pSize(1)*(rowNum(t)-1)+1, pSize(1)*(rowNum(t)+1)+1, pSize(2)*(colNum(t)-1)+1, pSize(2)*(colNum(t)+1)+1];
    %img = DrawTransColor(img, patchRange, [1 0 0]);
    %colorFrames(:, :, :, frameNum(t)+temporalOffset) = img;
%end

temporalOffset = bSize(3) + pSize(3);
for t = 1 : length(frameNum)
    img = colorFrames(:, :, :, frameNum(1)+temporalOffset);
    patchRange = [pSize(1)*(rowNum(t)-1)+1, pSize(1)*(rowNum(t)+1)+1, pSize(2)*(colNum(t)-1)+1, pSize(2)*(colNum(t)+1)+1];
    img = DrawTransColor(img, patchRange, [1 0 0]);
    colorFrames(:, :, :, frameNum(1)+temporalOffset) = img;
end

%scale the image back to the normal size
for i = 1:size(colorFrames, 4)
    img = colorFrames(:, :, :, i);
    normalFrames(:, :, :, i) = imresize(img, boxSize);
end

    
