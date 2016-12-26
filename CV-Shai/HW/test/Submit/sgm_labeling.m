function label_smooth_sgm = sgm_labeling(C, P1, P2);
%SGM_LABELING - find disparcity map based on minimum ssdd of 8 directions
%   
[m, n, ~] = size(C);
label_smooth_sgm = zeros(m, n);

%%
% Horizontal direction
for i=1:m
    L1 = dp_grade_slice (get_slice_direction(C, 1, i), P1, P2);
    L5 = dp_grade_slice (get_slice_direction(C, 5, i), P1, P2);
    [~, L1_min] = min(L1);
    [~, L5_min] = min(L5);
    label_smooth_sgm(i,:) = label_smooth_sgm(i,:) + L1_min + L5_min;
end

%%
% Vertical direction

for i=1:n
    L3 = dp_grade_slice (get_slice_direction(C, 3, i), P1, P2);
    L7 = dp_grade_slice (get_slice_direction(C, 7, i), P1, P2);
    [~, L3_min] = min(L3);
    [~, L7_min] = min(L7);
    label_smooth_sgm(:,i) = label_smooth_sgm(:,i) + L3_min' + L7_min';
end

%%
% Diagnals

for i= -m + 1: 1: n-1
    L2 = dp_grade_slice (get_slice_direction(C, 2, i), P1, P2);
    L4 = dp_grade_slice (get_slice_direction(C, 4, i), P1, P2);
    L6 = dp_grade_slice (get_slice_direction(C, 6, i), P1, P2);
    L8 = dp_grade_slice (get_slice_direction(C, 8, i), P1, P2);
    sub = diagnum2ind(m, n, i);
    [~, L2_min] = min(L2);
    [~, L6_min] = min(L6);
    label_smooth_sgm(sub) = label_smooth_sgm(sub) + L2_min + fliplr(L6_min);
    
    tmp = zeros([m,n]);
    [~, L4_min] = min(L4);
    [~, L8_min] = min(L8);
    tmp(sub) = L4_min + fliplr(L8_min);
    label_smooth_sgm = label_smooth_sgm + fliplr(tmp);
end

label_smooth_sgm = label_smooth_sgm /8;
end


function ind = diagnum2ind(m, n, diagnum)

 
if diagnum < 0
    row_sub = abs(diagnum)+1:1:m;
    col_sub = 1:1:min(length(row_sub),n);
    row_sub = row_sub(1:length(col_sub));
else 
    col_sub = abs(diagnum)+1:1:n;
    row_sub = 1:1:min(length(col_sub),m);
    col_sub = col_sub(1:length(row_sub));
end
ind = sub2ind([m,n], row_sub, col_sub);
end