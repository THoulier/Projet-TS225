function [X,Y, area] = area_of_interest()
    % choix de 2 points pour définir la zone d'interet
    [X,Y] = ginput(2);
    X = round(X);
    Y = round(Y);
   
    min_X = min(X(1),X(2));
    max_X = max(X(1),X(2));
    min_Y = min(Y(1),Y(2));
    max_Y = max(Y(1),Y(2));
    
    % coordonnées des points définissant la zone d'interet
%     top_left = [min_X max_Y]; 
%     top_right = [max_X max_Y];
%     bottom_left = [min_X min_Y];
%     bottom_right = [max_X min_Y];
    
    %area = [bottom_left(1) bottom_right(2); top_left(1) top_right(2)]; % area = [x_min x_max; y_min y_max]
    area = [min_X max_X; min_Y max_Y];
    
    x_start = min_X;
    y_start = min_Y;
    width = max_X - min_X;
    height = max_Y - min_Y;
    rectangle('Position',[x_start, y_start, width, height],'Curvature',0.3,'EdgeColor','r','LineWidth',3);
    
end