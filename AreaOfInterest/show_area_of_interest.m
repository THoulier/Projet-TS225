function [x_start,y_start,width, height] = show_area_of_interest(area_row,area_col,size)
    x_start = area_col(size(1));
    y_start = area_row(size(2));
    width = size(1);
    height = size(2);
    
    rectangle('Position',[x_start, y_start, width, height],'Curvature',0.3,'EdgeColor','r','LineWidth',3);
    
end