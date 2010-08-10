function [scaleFrames, boxSize] = GetScaleFrames(Frames, mask, clipSize)
    if size(Frames, 1) <= 0
        sprintf('empty frames')
        return
    end

    nFrame = size(mask, 3);
    box = [];
    for f_i=1:nFrame
        tmp = regionprops(mask(:, :, f_i), 'boundingbox');
        center = regionprops(mask(:, :, f_i), 'centroid');
        box(f_i, :) = [tmp.BoundingBox round(center.Centroid)];
    end

    diffX = [box(:, 3) - box(:, 5) + box(:, 1); box(:, 1) - box(:, 5)];
    diffY = [box(:, 4) - box(:, 6) + box(:, 2); box(:, 2) - box(:, 6)];
    maxHalfWidth = max(abs(diffX));
    maxHalfHeight = max(abs(diffY));

    clipFrames = [];
    for f_i=1:nFrame
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

    %return the original clip image size
    boxSize = [2*maxHalfHeight+1 2*maxHalfWidth+1];
end
