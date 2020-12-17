clear;
close all;
clc;

%% Parametres

img = double(imread('img/codebarre3.jpg'));
img_gray = get_img_gray(img);

%% Envoi d'un rayon

figure(1), imshow(uint8(img));
title('Code-barres');

% choix de nb points
nb = 2;
[X,Y] = ginput(nb);
line(X,Y);
X = round(X);
Y = round(Y);

% 
dist_euclidienne = sqrt(abs(X(1)-X(2))^2+abs(Y(1)-Y(2))^2);
U = round(2 * dist_euclidienne);
MA = [X(1) Y(1)];
MB = [X(2) Y(2)];
Mu = subdivision_segment(U-1, MA, MB);


%% Création de la signature 1 + binarisation

% création de la signature 1
signature1 = creation_signature(U-1, Mu, img_gray);

% axe des abscisse discretise
ab_disc = get_abs_disc(U-1, Mu);

% critere d'Otsu
N = 256;
histo = hist(signature1,N);
crit = Otsu(N, histo);
[maxi_histo, seuil] = max(crit);

% binarisation de la signature 1
signature1_binaire = binarisation(signature1, seuil);

% extrémités du segment
[extrem_gauche, extrem_droite] = find_Extremites(U, img_gray, Mu, seuil);


%% Subdivision + création signature 2 + binarisation

% subdivision du segment
u = 10;
subdi = 95*u;
seg_sub = subdivision_segment(subdi, extrem_gauche, extrem_droite);

% création de la signature 2
signature2 = creation_signature(subdi, seg_sub, img_gray);

% binarisation de la signature 2
signature2_binaire = binarisation(signature2, seuil);

% axe des abscisse discretise
ab2_disc = get_abs_disc(subdi, seg_sub);


%% Identification des chiffres

% Création de la mtrice des ElementA, ElementB et ElementC
ElementA_dup = dupTab(BDD_ElementType("A"),u);
ElementB_dup = dupTab(BDD_ElementType("B"),u);
ElementC_dup = dupTab(BDD_ElementType("C"),u);
Elements_dup = [ElementA_dup; ElementB_dup; ElementC_dup];

% Segmentation de la signature 2
Segment1 = signature2_binaire(u*3+1:u*3 + 6*7*u);
Segment2 = signature2_binaire((7*6+3+5)*u+1:(7*6+3+5)*u + 6*7*u);

% Identification des correspondances
Segment_total = [Segment1 Segment2];
tab_idx = identification_matching(u, Segment_total, Elements_dup);

% Traitement du résultat
[list_chiffres, list_classes] = index2number(tab_idx);


%% Affichage

figure(2);
subplot(121);
plot(histo)
title('Histogramme signature 1');
subplot(122);
plot(crit)
title("Critere d'Otsu");

figure(3);
subplot(121)
plot(ab_disc,signature1)
title('Signature 1')
subplot(122);
plot(ab_disc,signature1_binaire)
title('Binarisation de la signature 1')

figure(4);
subplot(121);
plot(ab2_disc,signature2)
title('Signature 2')
subplot(122);
plot(ab2_disc,signature2_binaire)
title('Signature 2 binarisée')
