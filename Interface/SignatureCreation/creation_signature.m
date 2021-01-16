function [signature] = creation_signature(subdi, seg_sub, img_gray)
   
    for i=1:subdi
        signature(i,1) = img_gray(round(seg_sub(i,2)),round(seg_sub(i,1)));
    end
    
end