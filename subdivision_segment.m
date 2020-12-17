function [segment_subdivise] = subdivision_segment(subdivision, extrem_gauche, extrem_droite)
    segment_subdivise = extrem_gauche;
    
    for i = 1:subdivision
        segment_subdivise(i,:) = extrem_gauche + (i/(subdivision-1)).*(extrem_droite-extrem_gauche);
    end 
end