function [area_label, area_label_size, area_centered, area_index] = get_area_of_interest(img_bw, num)
    area_index = [];
    min_size_code_barres = 0; 
    cnt = ones(1,num);
    area_label = -1;
    area_centered = -1*ones(1,num);

    
    for i = 1 : num
        [fd_h, fd_w] = find(img_bw == i); % indices
        %cnt(i) = sum(img_bw(fd_x(:))./i); % compte la taille
        [h, w] = size(fd_h);
        cnt(i) = h;
        area_centered(i) = is_area_centered(fd_h, fd_w, img_bw); % si oui, alors 1, sinon 0
        
        if (area_centered(i) == 1)
            if (cnt(i) > min_size_code_barres) % on cherche la zone la + grande
                min_size_code_barres = cnt(i);
                area_index = [fd_h, fd_w];
                area_label = i;
                area_label_size = cnt(i);
            end
        end
        
    end
     
%     i = 1;
%     j = 1;
%     for k = 1:length(area_index_line)-1
%         if (area_index_line(k) == area_index_line(k+1)-1)
%             area_index_line_matrix(i,j) = area_index_line(k);
%             i = i+1;
%         elseif ((area_index_line(k) ~= area_index_line(k+1)-1) && (area_index_line(k) == area_index_line(k-1)+1))
%             area_index_line_matrix(i,j) = area_index_line(k);
%             j = j+1;
%             i = 1;
%         else 
%             area_index_line_matrix(i,j) = area_index_line(k);
%         end
%     end
%     area_index_line_matrix(end,end) = area_index_line(end);
%     
%     area_size = [size(area_index_line_matrix,1) size(area_index_line_matrix,2)];
%     [area_row,area_col] = ind2sub(area_size,area_index_line);
end