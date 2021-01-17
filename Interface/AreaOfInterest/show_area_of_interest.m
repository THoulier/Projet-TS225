function [x_start,y_start,width,height] = show_area_of_interest(area_index)
    % Recherche de x_start
    x_start = min(area_index(:,2));
    
    % Recherche de y_start
    y_start = min(area_index(:,1)); 
    
    % Recherche de width
    width = 0;
    for j = 1 : length(area_index(:,2))-1
        if (area_index(j,2) ~= area_index(j+1,2))
            width = width+1;
        end
    end
    
    % Recherche de height
    height = 0;
    cnt = 0;
    for k = 1 : length(area_index(:,2))-1
        if (area_index(k,2) == area_index(k+1,2))
            cnt = cnt+1;
            if (cnt > height)
                height = cnt;
            end
        else
            cnt = 0;
        end
    end
    rectangle('Position',[x_start, y_start, width, height],'Curvature',0.3,'EdgeColor','r','LineWidth',3);
    
end