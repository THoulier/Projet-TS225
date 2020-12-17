function [extrem_gauche, extrem_droite] = find_Extremites(U, img_gray, Mu, seuil)
    extremites = [];

    for i = 1:U-1
        if (img_gray(round(Mu(i,2)),round(Mu(i,1))) < seuil)
            extremites(i,:) = [Mu(i,1) Mu(i,2)];
        end
    end

    extrem_gauche = [round(extremites(find(extremites,1,'first'),1)) round(extremites(find(extremites,1,'first'),2))];
    extrem_droite = [round(extremites(end,1)) round(extremites(end,2))];
end