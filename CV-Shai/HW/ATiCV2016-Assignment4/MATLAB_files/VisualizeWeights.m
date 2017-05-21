function   VisualizeWeights( W1 )

figure;
axis off
hold on
colormap gray

for w=1:25
    subplot (5,5,w);
    imagesc(vec2mat(W1(w,:),28)');
    pbaspect([1,1,1]);
    axis off
end
hold off
    
