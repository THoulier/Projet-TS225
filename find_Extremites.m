function [extrem_gauche, extrem_droite] = find_Extremites(subdivision, img_gray, seg_subdiv, seuil)
    extremites = [];

    for i = 1:subdivision-1
        if (img_gray(round(seg_subdiv(i,2)),round(seg_subdiv(i,1))) < seuil)
            extremites(i,:) = [seg_subdiv(i,1) seg_subdiv(i,2)];
        end
    end

    extrem_gauche = round([extremites(find(extremites,1,'first'),1) extremites(find(extremites,1,'first'),2)]);
    extrem_droite = round([extremites(end,1) extremites(end,2)]);
end