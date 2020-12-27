function [res] = is_area_centered(img,index_list)
    lines = size(img,1);
    columns = size(img,2);
    len_idx = length(index_list);

    res = 1; % 1 si la zone est centrée sur l'image, 0 sinon

    for m = 1 : len_idx
        for i = 1 : lines
           if (img(i,1) == index_list(m) || img(i,end) == index_list(m))
               res = 0;
           end
        end
        for i = 1 : columns
           if (img(1,i) == index_list(m) || img(end,i) == index_list(m))
               res = 0;
           end
        end
    end
end