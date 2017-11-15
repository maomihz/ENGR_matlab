%TURBULENT plot the turbulent data

% By submitting this assignment, I agree to the following:
%  “Aggies do not lie, cheat, or steal, or tolerate those who do”
%  “I have not given or received any unauthorized aid on this assignment”
%
% Name: 		XUCHENG GUO
% Section:      539
% Team:
% Assignment:   ICA 3
% Date:         30 January 2017

k = linspace(10, 10000, 10000);
tke = 1000 * k .^ (- 5 / 3);

subplot(2,2,1);
plot(k, tke);
title('Normal Plot');
xlabel('k');
ylabel('TKE');

subplot(2,2,2);
semilogx(k, tke);
title('semilogx plot');
xlabel('k');
ylabel('TKE');

subplot(2,2,3);
semilogy(k, tke);
title('semilogy plot');
xlabel('k');
ylabel('TKE');

subplot(2,2,4);
loglog(k, tke);
title('log-log plot');
xlabel('k');
ylabel('TKE');
