function [X,Y] = random_throw(area_of_interest)
    % fenetre de la zone d'interet
    x_min = area_of_interest(1,1);
    x_max = area_of_interest(1,2);
    y_min = area_of_interest(2,1);
    y_max = area_of_interest(2,2);
    
    x_moy = round((x_min+x_max)/2);
    y_moy = round((y_min+y_max)/2);
    
    % choix de 2 points aleatoires
%     X(1) = x_min;
%     X(2) = x_max;
    X(1) = randi([x_min, x_moy],1);
    X(2) = randi([x_moy, x_max],1);
    Y(1) = randi([y_min, y_max],1);
    Y(2) = randi([y_min, y_max],1);

end