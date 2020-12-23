clear;
close all;
clc;

%% Parametres

N = 256;
u = 5;
subdi = 95*u;

%% Image d un code barre

img = double(imread('img/codebarre3.jpg'));
img_gray = get_img_gray(img);

%% Envoi d'un rayon

figure(1), imshow(uint8(img));
title('Code-barres');

%Rayon a la main
[X,Y] = ginput(2);
line(X,Y);

X = round(X);
Y = round(Y);

%Discretisation du rayon en 2*Dist_euclidienne points
Dist_euclidienne = sqrt(abs(X(1)-X(2))^2+abs(Y(1)-Y(2))^2);
U = round(2 * Dist_euclidienne);

MA = [X(1) Y(1)];
MB = [X(2) Y(2)];
Mu(1,:)= MA;

for i = 2:U-1
    Mu(i,:) = MA + (i/(U-1)).*(MB-MA);
end 

%% Creation de la 1ere signature

% creation de la signature 1
signature1 = creation_signature(U-1, Mu, img_gray);

% axe des abscisse discretise
S = size(Mu);
ab = round(Mu(2,1)):(round(Mu(S(1),1))-round(Mu(2,1)))/(U-1):round(Mu(S(1),1))-(round(Mu(S(1),1))-round(Mu(2,1)))/(U-1);

% critere d'Otsu

histo = hist(signature1,256);
crit = Otsu(N, histo);
[maxi_histo, seuil] = max(crit);

% binarisation de la signature 1
signature1_binaire = binarisation(signature1, seuil);

% extremites du segment
[extrem_gauche, extrem_droite] = find_Extremites(U, img_gray, Mu, seuil);

%% Création segment subdivisé en un multiple de 95 (ie 95*u) + binarisation

seg_sub = subdivision_segment(subdi, extrem_gauche, extrem_droite);

% creation de la signature 2
signature2 = creation_signature(subdi, seg_sub, img_gray);

% binarisation de la signature 2
signature2_binaire = binarisation(signature2, seuil);

% axe des abscisse discretise
S2 = size(seg_sub);
ab2 = round(seg_sub(2,1)):(round(seg_sub(S2(1),1))-round(seg_sub(2,1)))/(subdi):round(seg_sub(S2(1),1))-(round(seg_sub(S2(1),1))-round(seg_sub(2,1)))/(subdi);

%% Identification des chiffres


%Base de donnee des Element
ElementA_dup = dupTab(BDD_ElementType("A"),u);
ElementB_dup = dupTab(BDD_ElementType("B"),u);
ElementC_dup = dupTab(BDD_ElementType("C"),u);

Elements_dup = [ElementA_dup; ElementB_dup; ElementC_dup];

%Segmentation Signature 2 en deux segments de 6 chiffres
Segment1 = signature2_binaire(u*3+1:u*3 + 6*7*u);
Segment2 = signature2_binaire((7*6+3+5)*u+1:(7*6+3+5)*u + 6*7*u);

% Identification des correspondances
Segment_total = [Segment1 Segment2];
tab_idx = identification_matching(u, Segment_total, Elements_dup);

%Traitement du resultat : recuperation des 12 chiffres et de leur classe
[list_chiffres, list_classes] = index2number(tab_idx);

%Deduction du premier chiffre
chiffre1 = get_chiffre1(list_classes(1:6));

%Deduction de la cle de controle
cle = get_cle_controle([chiffre1 list_chiffres(1:11)]);

%% Affichage

%Signatures et histogramme (critere Otsu)
figure(2);
subplot(121);
plot(histo)
title('Histogramme signature 1');
subplot(122);
plot(crit)
title("Critere d'Otsu");

figure(3);
subplot(121)
plot(ab,signature1)
title('Signature 1')
subplot(122);
plot(ab,signature1_binaire)
title('Binarisation de la signature 1')

figure(4);
subplot(121);
plot(ab2,signature2)
title('Signature 2')
subplot(122);
plot(ab2,signature2_binaire)
title('Binarisation de la signature 2')

%Chiffres obtenus et cle de controle

disp("Liste des chiffres : ");
disp(list_chiffres);

disp("Chiffre 1 : ");
disp(chiffre1);

disp("Cle de controle : ");
disp(cle);

