%MAIN script

%%
%PART A

s = 128;
D = haar2d(s);
D = sparse(D)'; %use sparse rep


%Q4 - Wrapping Funciton 
sig_n = 0.05;
k = 20;
p = 0.2;
dr_ratio = 0.02;
[C_g, C_d, C_b,  D, T, x, y_d, y_g, y_b, y0] = genData(p,k, dr_ratio, []);

s = sqrt(length(y0));

subplot(2, 2, 1);
imshow(reshape(y0, s, s))
xlabel('Original');

subplot(2, 2, 2);
imshow(reshape(C_d'*y_d, s, s))
title('deletion');

subplot(2, 2, 3);
imshow(reshape(y_b, s, s))
xlabel('blur');

subplot(2, 2, 4);
imshow(reshape(pinv(C_d)*y_d, s, s))
xlabel('compresed sensing');

%%
%PART B 
%sprintf('Part B')
%PartB()

%%
%PART C
%sprintf('Part C')
%PartC()

%%
% PART D
%sprintf('Part D')
%PartD()
