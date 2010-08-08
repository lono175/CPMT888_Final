function pDerivative = GetDerivative(scaleFrames, bSize)
%compute 3D derivative, the size will shrink by bSize*2 for each dimension
imheight = size(scaleFrames, 1);
imwidth = size(scaleFrames, 2);
nFrame = size(scaleFrames, 3);
pDerivative = [];
for y = 1 + bSize(1): imheight - bSize(1)
    for x = 1 + bSize(2): imwidth - bSize(2)
        for t = 1 + bSize(3): nFrame - bSize(3)
            block = scaleFrames(y-bSize(1):y+bSize(1), x-bSize(2):x+bSize(2), t-bSize(3):t+bSize(3));
            [Ix,Iy,It] = partial_derivative_3D(block);
            pDerivative(y-bSize(1), x-bSize(2), t-bSize(3), :) = [Ix, Iy, It];
        end
    end
end
