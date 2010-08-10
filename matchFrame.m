function allCorr = MatchFrame(queryG, patchG)
%queryG = [];
%queryG(:, :, :, :) = patchG( :, : , 1, :, :);
allCorr = [];
for q = 1: size(queryG, 3)
    rowCorr = [];
    for t = 1: size(patchG, 3)
        %sumCorr = 0;
        partCorr = [];
        for y = 1: size(patchG, 1)
            for x = 1: size(patchG, 2)
                patch(:, :) = patchG(y, x, t, :, :);
                query(:, :) = queryG(y, x, q, :, :);
                corr = GetCorr(patch, query);
                %sumCorr = sumCorr + corr;
                partCorr = [partCorr corr];
            end
        end
        rowCorr = [rowCorr mean(partCorr)];
    end
    allCorr = [allCorr; rowCorr];
end
