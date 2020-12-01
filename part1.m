clear;
close all;
clc;

%% Parametres

N = 2;
img = double(imread('img/codebarre.jpg'));

R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);

img_gray = (R+G+B)/3;

%% Envoie d'un rayon

figure(1), imshow(uint8(img));
title('Code-barres');


[X,Y] = ginput(N);
line(X,Y);

X = round(X);
Y = round(Y);

Dist_euclidienne = sqrt(abs(X(1)-X(2))^2+abs(Y(1)-Y(2))^2);
U = round(2 * Dist_euclidienne);

MA = [X(1) Y(1)];
MB = [X(2) Y(2)];
Mu(1,:)= MA;

for i = 2:U-1
    Mu(i,:) = MA + (i/(U-1)).*(MB-MA);
end 

%% Trouver les extr�mit�s

seuil = 125;
extremites = [];
for i = 1:U-1
    if (img_gray(round(Mu(i,2)),round(Mu(i,1))) < seuil)
        extremites(i,:) = [Mu(i,1) Mu(i,2)];
    end
end

% for i = 1:U-1
%     if (img_gray(round(Mu(i,2)),round(Mu(i,1))) < seuil)
%         profil(i,1) = img_gray(round(Mu(i,2)),round(Mu(i,1)));
%     else
%         profil(i,1) = 0;
%     end
% end

extrem_gauche = [round(extremites(find(extremites,1,'first'),1)) round(extremites(find(extremites,1,'first'),2))];
extrem_droite = [round(extremites(end,1)) round(extremites(end,2))];

%% Cr�ation segment subdivis� en un multiple de 95





