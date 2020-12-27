function [area_label, is_area_center] = get_area_of_interest(img_bw, num)
%function [area_label, is_center, area_row,area_col,area_size] = get_area_of_interest(img_bw, num)

    area_index_line = [];
    min_size_code_barres = 0; % valeur arbitraire
    cnt = ones(1,num);
    area_label = -1;
    is_area_center = -1*ones(1,num);
    
    for i = 1 : num
        fd = find(img_bw == i); % indices
        cnt(i) = sum(img_bw(fd(:))./i); % compte la taille
        is_area_center(i) = is_area_centered(img_bw,fd); % si oui, alors 1, sinon 0
        
        if (is_area_center(i) == 1)
            if (cnt(i) > min_size_code_barres) % on cherche la zone la + grande
                min_size_code_barres = cnt(i);
                area_index_line = fd;
                area_label = i;
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