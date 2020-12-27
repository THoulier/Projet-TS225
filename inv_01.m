function [matrix_inv_01] = inv_01(matrix)
    lines = size(matrix(:,1),1);
    columns = size(matrix(:,1),2);
    matrix_inv_01 = matrix.*(-1) + ones(lines, columns);

    % Si c'est un 0 alors res = 0*(-1) + 1 =  0 + 1 = 0
    % Si c'est un 1 alors res = 1*(-1) + 1 = -1 + 1 = 0
end