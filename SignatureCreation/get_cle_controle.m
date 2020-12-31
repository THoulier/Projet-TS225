function [cle] = get_cle_controle(list_chiffres)
    S_pair = 0;
    S_impair = 0;

    for i = 1:6
        S_pair = S_pair + list_chiffres(2*i);
        S_impair = S_impair + list_chiffres(2*i-1);
    end
    
    res = S_impair + 3*S_pair;
    cle = mod(10 - mod(res,10),10);
end