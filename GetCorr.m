function m12=corr(G1, G2)
    epsilon = 0.000001;
    G = [G1;G2];
    M12 = G'*G;
    M1 = G1'*G1;
    M2 = G2'*G2;

    delta12 = GetDeltaR(M12)
    delta1 = GetDeltaR(M1)
    delta2 = GetDeltaR(M2)

    m12 = delta12 / (min(delta1, delta2) + epsilon);
end
