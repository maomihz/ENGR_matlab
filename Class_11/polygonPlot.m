% POLYGONPLOT plot the polygons
%
% By submitting this assignment, I agree to the following:
%  “Aggies do not lie, cheat, or steal, or tolerate those who do”
%  “I have not given or received any unauthorized aid on this assignment”
%
% Name: 		XUCHENG GUO
% Section:      539
% Team:
% Assignment:   ICA 3
% Date:         20 Feburary 2017

load('polygons');
figure(i);
for i = 1:length(polygons)
    subplot(3,3,i);
    patch(polygons(i).x, polygons(i).y, polygons(i).colorCode);
end
