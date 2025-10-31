clear;clc;
load('gasprice.mat')
figure1 = plot(year,gasprices);
xlable('year')
ylable('$')
title('gas prices by year')
cow = mean(gasprices,2);
cow(2)
figure2 = surf(gasprices);