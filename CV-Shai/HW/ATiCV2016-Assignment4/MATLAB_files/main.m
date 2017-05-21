%%
%% ATICV2016 Ex. 4 - MNIST ANN:
% ---------------
%
% Construction an ANN with inpput size of 28*28=784  ,  
% a Hidden layer with a variable amount of (hidden) units
% and an output layer with 10 units.

load('ATICV2016mnist.mat')     % Load dataset


%  An Example from the training and testing sets:

%% Display a sample digit from both sets

% You can "comment" this section after running it once.


NumberOfImages=1;   % from each set)
Target1=randperm(2000,NumberOfImages);
Target2=randperm(1500,NumberOfImages);


figure;
colormap('gray');
hold on;
subplot(1,2,1)
imagesc(vec2mat(TrainingSetS(Target1,2:end),28));    %   Print a sample Training charachter 
title(['Training Set - GT=', num2str(TrainingSetS(Target1,1))]);
pbaspect([1,1,1])

subplot(1,2,2)
imagesc(vec2mat(TestingSet(Target2,2:end),28));    %   Print a sample Testing charachter 
title(['TestSet - GT=', num2str(TestingSet(Target2,1))]);
pbaspect([1,1,1])
hold off;

%% Initialization as described in the Ex:

% Fc1Units=100;
% Fc2Units=10;
% 
% W1 =  0.001*randn (Fc1Units,784);
% W2 =  0.01*randn (Fc2Units,Fc1Units);
% B1=0.01*randn(Fc1Units,1);
% B2=0.01*randn(Fc2Units,1);

%%    Your Code Here