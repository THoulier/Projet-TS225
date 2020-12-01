clear;
close all;
clc;

%% Parametres

img = double(imread('img/codebarre2.jpg'));

R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);

img_gray = (R+G+B)/3;



%% Envoie d'un rayon

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

U2 = 2*95;
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