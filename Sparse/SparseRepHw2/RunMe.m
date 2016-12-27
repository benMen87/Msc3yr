%MAIN script

%%
%PART A

global S;
S = 128;
D = haar2d(S);
D = sparse(D)'; %use sparse rep


%Q4 - Wrapping Funciton 
sig_n = 0.05;
k = 20;
p = 0.2;
dr_ratio = 0.02;
[C_g, C_d, C_b,  D, T, x, y_d, y_g, y_b, y0] = genData(p,k, dr_ratio, D);

s = sqrt(length(y0));

subplot(2, 2, 1);
imshow(reshape(y0, s, s), [min(y0), max(y0)])
xlabel('Original');

y_dd = C_d'*y_d;
subplot(2, 2, 2);
imshow(reshape(y_dd, s, s), [min(y_dd), max(y_dd)])
title('deletion');

subplot(2, 2, 3);
imshow(reshape(y_b, s, s), [min(y_b), max(y_b)])
xlabel('blur');

y_compers = pinv(full(C_g))*y_g;
subplot(2, 2, 4);
imshow(reshape(y_compers, s, s), [min(y_compers), max(y_compers)])
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
