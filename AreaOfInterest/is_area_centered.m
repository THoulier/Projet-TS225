function [res] = is_area_centered(fd_x, fd_y, img)
%function [res] = is_area_centered(img,index_list)
    res = 1; % 1 si la zone est centrée sur l'image, 0 sinon
    [h, w] = size(img);
    [h1, w1] = size(find(fd_x == 1));
    [h2, w2]= size(find(fd_x == h));
    [h3, w3]= size(find(fd_y == 1));
    [h4, w4]= size(find(fd_y == w));
    if (h1 ~= 0 || h2 ~= 0 || h3 ~= 0 || h4 ~= 0)
        res = 0;
    end
%     lines = size(img,1);
%     columns = size(img,2);
%     len_idx = length(index_list);
% 
%     res = 1; % 1 si la zone est centrée sur l'image, 0 sinon
% 
%     m = 1;
%     while (m <= len_idx && res == 1)
%         for i = 1 : lines
%            if (img(i,1) == index_list(m) || img(i,end) == index_list(m))
%                res = 0;
%            end
%         end
%         for i = 1 : columns
%            if (img(1,i) == index_list(m) || img(end,i) == index_list(m))
%                res = 0;
%            end
%         end
%         m = m+1;
%     end
end