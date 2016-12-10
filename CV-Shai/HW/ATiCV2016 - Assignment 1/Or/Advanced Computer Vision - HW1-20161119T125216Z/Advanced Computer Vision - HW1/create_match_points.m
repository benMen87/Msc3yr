src_test = imread(fullfile(pwd,'my_src_2.jpg'));
dst_test = imread(fullfile(pwd,'my_dst_2.jpg'));

figure;imshow(src_test)
[xs,ys] = getpts(gcf);
hold on
plot(xs,ys,'+r')
number=[1:25]';
text(xs,ys,num2str(number),'Color','r','FontSize', 14)

figure;imshow(dst_test)
[xd,yd] = getpts(gcf);
hold on
plot(xd,yd,'+r')
text(xd,yd,num2str(number),'Color','r','FontSize', 14)

match_p_src=round([xs';ys']);
match_p_dst=round([xd';yd']);
save('matches_test.mat','match_p_src', 'match_p_dst');
% matches_test = struct('match_p_src',round([xs';ys']),'match_p_dst',round([xd';yd']));
% save('matches_test.mat','matches_test');     