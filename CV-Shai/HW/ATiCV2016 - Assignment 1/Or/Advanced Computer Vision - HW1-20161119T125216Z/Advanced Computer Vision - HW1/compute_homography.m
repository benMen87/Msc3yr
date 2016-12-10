function [H] = compute_homography(mp_src, mp_dst, inliers_percent, max_err)
    
    best_mse=-1;
    best_fit_percent=-1;
    num_of_points=size(mp_src,2);
    min_num_of_points=4; %Homography needs 4 points to compute model
    H=zeros(3);
    drawn_points = zeros(0,min_num_of_points);
    
    % assume P=0.99 for RANSAC, to compute k for # of iterations
    p=0.99;
    n=min_num_of_points;
    w=inliers_percent;
    %k=round((log(1-p))/(log(1-w^n)));
    k=round(log(1-p)/log(1-w^n));
    
    for i=1:k
        % randomize 4 coordinates from mp_src/mp_dst
        r=randperm(num_of_points,min_num_of_points);
        while any(ismember(drawn_points,r,'rows'))
             r=randperm(num_of_points,min_num_of_points);
        end        
        H_temp= compute_homography_naive(mp_src(:,r), mp_dst(:,r));
        [fit_percent, dist_mse] = test_homography(H_temp, mp_src, mp_dst, max_err);
        if best_mse==-1
              best_mse=dist_mse;      
        end
        if (best_fit_percent<=fit_percent) 
            %if (dist_mse<=best_mse)
                best_fit_percent=fit_percent;
                best_mse=dist_mse;
                 H=H_temp;
            %end
        end
        drawn_points(end+1,:) = r;
    end

end

