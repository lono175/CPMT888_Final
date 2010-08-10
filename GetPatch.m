function patchG = GetPatch(oriMask, actionType)

bSize = [2, 2, 2]; %half block size to compute the derivative
pSize = [2, 2, 2]; %half ST patch size 
clipSize = [80,40];

maskStr = sprintf('mask=oriMask.%s;', actionType);
eval(maskStr);
frame_dir = actionType;

nFrame = size(mask, 3);
Frames = LoadFrames(frame_dir, nFrame);
scaleFrames = GetScaleFrames(Frames, mask, clipSize);

%compute 3D derivative
pDerivative = GetDerivative(scaleFrames, bSize);

%compute G matrix for each ST patches
patchG = GetG(pDerivative, pSize);
