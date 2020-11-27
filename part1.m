clear;
close all;
clc;

%% Parametres

N = 2;
img = imread('img/codebarre.jpg');



%% Display

figure(1), imshow(img);
title('Code-barres');

[X,Y] = ginput(N);

line(X,Y);