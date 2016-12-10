function [fit_percent, dist_mse] = test_homography(H, mp_src, mp_dst, max_err)
    
    valid_points=0;
    dist_mse=0;
    L=size(mp_src,2);
    for i=1:L
        p=H*[mp_src(1,i), mp_src(2,i), 1]';
        p=round([p(1)/p(3), p(2)/p(3), 1]);
         x_dist=p(1)-mp_dst(1,i);
         y_dist=p(2)-mp_dst(2,i);
        dist=sqrt(x_dist^2 + y_dist^2);
        if dist<=max_err
            valid_points=valid_points+1;
            dist_mse=dist_mse+dist^2;
        end    
    end
    fit_percent=valid_points/L;
   dist_mse=dist_mse/L;
end



