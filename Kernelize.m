function designMat = Kernelize(kernelG, patchG)
    designMat = [];
    for t = 1: size(patchG, 3)
        row = [];
        for y = 1: size(patchG, 1)
            for x = 1: size(patchG, 2)
                patch(:, :) = patchG(y, x, t, :, :);
                %correlate the part with bend
                for q = 1: size(kernelG, 3)
                    %for qy = 1: size(kernelG, 1)
                    %for qx = 1: size(kernelG, 2)
                    query(:, :) = kernelG(y, x, q, :, :);
                    corr = GetCorr(patch, query);
                    row = [row corr];
                    %end
                    %end
                end
            end
        end
        designMat = [designMat; row];
    end
end
