function deltaR=GetReltaR(M)
    %fullRank = rank(M);
    [U,S,V] = svd(M);

    partM = M(1:2, 1:2);
    %partRank = rank(partM);
    [U,partS,V] = svd(partM);
    if partS(2, 2) ~= 0
        deltaR = S(2, 2)*S(3,3)/partS(1,1)/partS(2, 2);
    else
        deltaR = S(2, 2)/partS(1,1);
    end
end
