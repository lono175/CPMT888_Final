function patchG = GetG(pDerivative, pSize)
    %compute G matrix for each 
    imheight = size(pDerivative, 1);
    imwidth = size(pDerivative, 2);
    nFrame = size(pDerivative, 3);
    scale = 1;
    patchG = [];
    i = 0;
    for y = 1 + pSize(1): pSize(1)/scale: imheight - pSize(1)
        i = i + 1;
        j = 0;
        for x = 1 + pSize(2): pSize(2)/scale: imwidth - pSize(2)
            j = j + 1;
            k = 0;
            %for t = 1 + pSize(3): pSize(3)/scale: nFrame - pSize(3)
            for t = 1 + pSize(3): 1: nFrame - pSize(3)
                %[y x t]
                k = k + 1;
                G = [];
                block = pDerivative(y-pSize(1):y+pSize(1), x-pSize(2):x+pSize(2), t-pSize(3):t+pSize(3), :);
                G = reshape(block, numel(block)/3,3);
                patchG(i, j, k, :, :) = G;
            end
        end
    end
end
