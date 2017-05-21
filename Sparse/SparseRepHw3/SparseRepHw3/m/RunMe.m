close all; 
clear all;

%A 
fname = 'my_pic.jpg';
train_size = 60000;
max_sparsity = 30;
eta =1; 
b = 8;
C = 1.15;
sigma = 20;
noise_threshold  = sigma^2*C*b^2;

M = 64; N = 256; D0 = randn(M,N); %option 1
%M = 64; N = 400; D0 = randn(M,N); %option 2
%M = 64; N = 256; load D0.mat; %option 3  

y0 = imread(fname);
y0 = double(rgb2gray(y0));
[ym, yn] = size(y0);
y = y0 + sigma * randn(size(y0));

dynamic_range = max(y(:)) - min(y(:));

%B 
len_m = ym - b + 1;
len_n = yn - b + 1;
len_p = len_m * len_n ;
id1 = repmat((0:b-1) ,b,1);
id2 = repmat((0:b-1)',1,b);
id1 = repmat(id1(:),1,len_p);
id2 = repmat(id2(:),1,len_p);
id3 = repmat((1:len_m), len_n , 1);
id4 = repmat((1:len_n)',1, len_m);
id3 = repmat(id3(:)',b^2,1);
id4 = repmat(id4(:)',b^2,1);

patch_m = id1+id3;
patch_n = id2+id4;

patches = reshape(y(patch_m(:) + ym*(patch_n(:)-1)),b^2,len_p);

%C
patches_mean = mean(patches,1);
patches = patches - repmat(patches_mean,b^2,1);

%D 
Cp = sparse(patch_m(:) + ym*(patch_n(:)-1), 1:len_p*b^2,1);
Cp_sum = sparse(1:ym*yn,1:ym*yn,sum(Cp,2).^-1);
Cp = Cp_sum*Cp;

clear id* len* patch_*

%E 
Dictionary = D0;
%Dictionary = odl(patches,D0,train_size,max_sparsity,noise_threshold,eta);

%F 
Dictionary_norms = sqrt(sum(Dictionary.^2,1));
Dictionary = Dictionary/diag(Dictionary_norms);

%G
X = sparse(zeros(N,size(patches,2)));
for p = 1:size(patches,2)
    yy = patches(:,p);
    if sum(abs(yy)) ~= 0
        r = yy;
        T = zeros(max_sparsity,1);
        k = 0;
        err = noise_threshold*10 +1;
        while k < max_sparsity && err > noise_threshold
            k = k+1;
            [~,i] = max(abs(Dictionary'*r));
            T(k) = i;
            x = Dictionary(:,T(1:k)) \ yy;
            r = yy - Dictionary(:,T(1:k))*x;
            err = norm(r)^2;
        end
        X(T(1:k),p) = x;
    end
end

%H
rmse = @(X) sqrt(mean(sum(X.^2,1)));

Y_hat = Dictionary*X + repmat(patches_mean,M,1);
Y_mean = repmat(patches_mean,M,1);
y_hat = Cp*Y_hat(:);
y_mean = Cp*Y_mean(:); 

disp(['RMSE of the representation: ' num2str(rmse(patches-Dictionary*X))]);
disp(['noisy PSNR = ' num2str(psnr(y(:),y0(:),dynamic_range)) ', reconstructed PSNR = ' num2str(psnr(y0(:),y_hat(:),dynamic_range))]);

figure;
subplot(221); imshow(reshape(y0,ym,yn),[]); title('original'); cmap = colormap;
subplot(222); imshow(reshape(y,ym,yn),cmap);  title('noisy');
subplot(223); imshow(reshape(y_hat,ym,yn),cmap); title('reconstructed');
subplot(224); imshow(reshape(y_mean,ym,yn),cmap); title('mean');
