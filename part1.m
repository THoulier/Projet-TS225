clear;
close all;
clc;

%% Parametres

img = double(imread('img/codebarre2.jpg'));

R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);

img_gray = (R+G+B)/3;

%% Envoi d'un rayon

figure(1), imshow(uint8(img));
title('Code-barres');


[X,Y] = ginput(2);
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

%% Creation de la 1ere signature
for i=1:U-1
    signature1(i,1) = img_gray(round(Mu(i,2)),round(Mu(i,1)));
end

S = size(Mu);
%axe des abscisse discretise
ab = round(Mu(2,1)):(round(Mu(S(1),1))-round(Mu(2,1)))/(U-1):round(Mu(S(1),1))-(round(Mu(S(1),1))-round(Mu(2,1)))/(U-1);

%% Critere d'Otsu

histo = hist(signature1,256)

N = 256;
denom = sum(histo);
w_k = [];
mu_k = [];

for k = 0:N-1
    S = 0;
    S2 = 0;
    for i = 0:k
        S = S + histo(i+1);
        S2 = S2 + i*histo(i+1);
    end
    w_k = [w_k  S/denom];
    mu_k = [mu_k S2/denom];
end


crit_k = w_k.*(mu_k(N)-mu_k).^2 + (1-w_k).*mu_k.^2;
[a, seuil] = max(crit_k);

figure;
subplot(121);
plot(histo)
title('Histogramme signature 1');
subplot(122);
plot(crit_k)
title('Critere d Otsu');

%% Binarisation signature 1

signature1_binaire(signature1 > seuil) = 1;
signature1_binaire(signature1 <= seuil) = 0;

figure;
subplot(121)
plot(ab,signature1)
title('signature 1')
subplot(122);
plot(ab,signature1_binaire)
title('Binarisation de la signature 1')

%% Trouver les extr�mit�s

extremites = [];

for i = 1:U-1
    if (img_gray(round(Mu(i,2)),round(Mu(i,1))) < seuil)
        extremites(i,:) = [Mu(i,1) Mu(i,2)];
    end
end

extrem_gauche = [round(extremites(find(extremites,1,'first'),1)) round(extremites(find(extremites,1,'first'),2))];
extrem_droite = [round(extremites(end,1)) round(extremites(end,2))];

%% Cr�ation segment subdivis� en un multiple de 95 + binarisation

MA2 = extrem_gauche;
MB2 = extrem_droite;
segment(1,:)= MA2;

u = 2;
U2 = u*95;
for i = 1:U2
    segment(i,:) = MA2 + (i/(U2-1)).*(MB2-MA2);
end 

for i=1:U2
    signature2(i,1) = img_gray(round(segment(i,2)),round(segment(i,1)));
end

signature2_binaire(signature2 > seuil) = 1;
signature2_binaire(signature2 <= seuil) = 0;

S2 = size(segment);
%axe des abscisse discretise
ab2 = round(segment(2,1)):(round(segment(S2(1),1))-round(segment(2,1)))/(U2):round(segment(S2(1),1))-(round(segment(S2(1),1))-round(segment(2,1)))/(U2);

figure;
subplot(121);
plot(ab2,signature2)
title('signature 2')
subplot(122);
plot(ab2,signature2_binaire)
title('signature 2 binaris�')

%% Identification des chiffres


% ElementA = [114 102 108 66 92 78 80 68 72 116];
% ElementB = [58 76 100 94 98 70 122 110 118 104];
% ElementC = [13 25 19 61 35 49 47 59 55 11];

% dec2bin(ElementA,7);

%Element_A = create_table_Element_numero();%("A",1);
% Element_B = create_table_Element_numero("B",1);
% Element_C = create_table_Element_numero("C",1);


%Base de donnee
ElementA = [1 1 1 0 0 1 0 ; 1 1 0 0 1 1 0 ; 1 1 0 1 1 0 0 ; 1 0 0 0 0 1 0 ; 1 0 1 1 1 0 0 ; 1 0 0 1 1 1 0 ; 1 0 1 0 0 0 0 ; 1 0 0 0 1 0 0 ; 1 0 0 1 0 0 0 ; 1 1 1 0 1 0 0];
ElementB = [1 0 1 1 0 0 0 ; 1 0 0 1 1 0 0 ; 1 1 0 0 1 0 0 ; 1 0 1 1 1 1 0 ; 1 1 0 0 0 1 0 ; 1 0 0 0 1 1 0 ; 1 1 1 1 0 1 0 ; 1 1 0 1 1 1 0 ; 1 1 1 0 1 1 0 ; 1 1 0 1 0 0 0];
ElementC = [0 0 0 1 1 0 1 ; 0 0 1 1 0 0 1 ; 0 0 1 0 0 1 1 ; 0 1 1 1 1 0 1 ; 0 1 0 0 0 1 1 ; 0 1 1 0 0 0 1 ; 0 1 0 1 1 1 1 ; 0 1 1 1 0 1 1 ; 0 1 1 0 1 1 1 ; 0 0 0 1 0 1 1];
ElementA_dup = dupTab(ElementA,u);
ElementB_dup = dupTab(ElementB,u);
ElementC_dup = dupTab(ElementC,u);

Elements_dup = [ElementA_dup; ElementB_dup; ElementC_dup];
%Segmentation Signature 2

Segment1 = signature2_binaire(u*3+1:u*3 + 6*7*u);
Segment2 = signature2_binaire((7*6+3+5)*u+1:(7*6+3+5)*u + 6*7*u);


[norm, idx] = get_number(Elements_dup,zeros(1,14));

tab_index = [];
for i = 1:7*u:length(Segment1)
    [norm, idx] = get_number(Elements_dup,Segment1(i:i+7*u-1));
    tab_index = [tab_index idx];
end
