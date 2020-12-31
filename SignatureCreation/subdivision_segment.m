function [segment_subdivise] = subdivision_segment(subdivision, extrem_gauche, extrem_droite)
    segment_subdivise = extrem_gauche;
    
    for i = 1 : subdivision+1
        segment_subdivise(i,:) = extrem_gauche + ((i-1)/subdivision).*(extrem_droite-extrem_gauche);
    end 
end