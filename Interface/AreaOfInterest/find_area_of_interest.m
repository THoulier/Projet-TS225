function [D_T_binaire] = find_area_of_interest(sigma_g, sigma_t, img)
    %% Filtre de Canny
    
    % Paramètres pour génération une gaussienne
    range_g = -3*sigma_g:3*sigma_g;
    [X_g,Y_g] = meshgrid(range_g);
    
	% Dérivées : horizontales (canny_X) et verticales (canny_Y)
    canny_x = -X_g.*(1/(sqrt(2*pi)*sigma_g^3)).*exp(-(X_g.^2+Y_g.^2)/(2*sigma_g^2));
    canny_y = -Y_g.*(1/(sqrt(2*pi)*sigma_g^3)).*exp(-(X_g.^2+Y_g.^2)/(2*sigma_g^2));
    
    % Calcul des gradients
    grad_Ix = conv2(img,canny_x, 'same'); % option 'same' pour avoir la meme taille en sortie qu'en entrée
    grad_Iy = conv2(img,canny_y, 'same');
    
    % Normalisation des vecteurs du gradient 
    grad_I_norm = sum(sum(sqrt(grad_Ix.^2 + grad_Iy.^2)));
    grad_Ix_norm = grad_Ix./grad_I_norm;
    grad_Iy_norm = grad_Iy./grad_I_norm;


    %% Passe-bas gaussien
    
    % Paramètres pour génération une gaussienne
    range_t = -3*sigma_t:3*sigma_t;
    [X_t,Y_t] = meshgrid(range_t);
    
    % Gaussienne 2D
    W_passe_bas = (1/(sqrt(2*pi)*sigma_t)).*exp((-(X_t.^2+Y_t.^2))/(2*sigma_t^2)); 
    W_passe_bas_norm = W_passe_bas/(sum(sum(W_passe_bas)));

    %% Mesure de cohérence
    
    % Composantes du tenseur
    Txx = conv2(grad_Ix_norm.^2, W_passe_bas_norm, 'same');
    Tyy = conv2(grad_Iy_norm.^2, W_passe_bas_norm, 'same');
    Txy = conv2(grad_Iy_norm.*grad_Ix_norm, W_passe_bas_norm, 'same');
    
    % Mesure de cohérence D_T
    D_T = sqrt((Txx-Tyy).^2 + 4*Txy.^2)./(Txx+Tyy);

    % Mesure de cohérence binarisée 
    seuil = 0.99; % valeur arbitraire
    for i = 1:length(D_T(1,:))
        for j = 1:length(D_T(:,1))
            if D_T(j,i) > seuil  
                D_T_binaire(j,i) = 0;
            else 
                D_T_binaire(j,i) = 1;
            end

        end
    end

    %% Affichage
    
    % Affichage des dérivées (CANNY)
    figure;
    subplot(121);
    surf(canny_x);
    colorbar;
    title("Dérivée horizontale (canny_y)");
    hold on
    subplot(122);
    surf(canny_y);
    colorbar;
    title("Dérivée verticale (canny_x)");
    
    % Affichage des gradients (CANNY)
    figure;
    subplot(121);
    surf(grad_Ix_norm);
    colorbar;
    title("Gradient Ix");
    hold on;
    subplot(122);
    surf(grad_Iy_norm);
    colorbar;
    title("Gradient Iy");
    
    % Affichage des dérivées (PASSE_BAS GAUSSIEN)
    figure;
    surf(W_passe_bas_norm);
    colorbar;
    title("Passe-bas gaussien");

    
end