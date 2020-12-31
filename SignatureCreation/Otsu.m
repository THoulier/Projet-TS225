function [crit_k] = Otsu(N, histo)
    denom = sum(histo);
    w_k = [];
    mu_k = [];

    for k = 0:N-1
        S = 0;
        S2 = 0;
        for i = 0:k
            S = S + histo(i+1);
            S2 = S2 + i*histo(i+1);
        end
        w_k = [w_k  S/denom];
        mu_k = [mu_k S2/denom];
    end
    
    crit_k = w_k.*(mu_k(N)-mu_k).^2 + (1-w_k).*mu_k.^2;
end