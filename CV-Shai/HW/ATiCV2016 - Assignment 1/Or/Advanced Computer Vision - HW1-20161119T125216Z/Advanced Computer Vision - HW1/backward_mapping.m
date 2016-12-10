function [ I_merged ] = backward_mapping(H, src_im, I_merged,  r_offset, c_offset)

    s_src_rows=size(src_im,1);
    s_src_columns=size(src_im,2);
    % find grid of the new image:
    p1=H*[1,1,1]'; % left top
    p2=H*[1,s_src_rows,1]'; % left bottom
    p3=H*[s_src_columns, 1,1]'; %right top
    p4=H*[s_src_columns, s_src_rows, 1]'; % right bottom
    
    % normalize by w':
    p1=[p1(1)/p1(3), p1(2)/p1(3), 1];
    p2=[p2(1)/p2(3), p2(2)/p2(3), 1];
    p3=[p3(1)/p3(3), p3(2)/p3(3), 1];
    p4=[p4(1)/p4(3), p4(2)/p4(3), 1];
    
    % finds the min/max of X and Y of the new image: 
    x_min=floor(min([p1(1); p2(1); p3(1); p4(1)]));
    y_min=floor(min([p1(2); p2(2); p3(2); p4(2)]));
    x_max=floor(max([p1(1); p2(1); p3(1); p4(1)]));
    y_max=floor(max([p1(2); p2(2); p3(2); p4(2)]));
   

    H_inverse=H\eye(3);
    [r, c, d] = size(I_merged);
   
    % calculate the new image:
    for i=x_min:x_max
        for j=y_min:y_max
            temp_index=H_inverse*[i,j,1]';
            index=[temp_index(1)/temp_index(3), temp_index(2)/temp_index(3)];
            if (index(1)>s_src_columns) || (index(1)<1) || (index(2)>s_src_rows) || (index(2)<1)
                continue;
            end
            dx=mod(index(1),1);
            dy=mod(index(2),1);
            x1=floor(index(1));
            y1=floor(index(2));
            x2=x1+1;
            y2=y1+1;
            %B_linear_val=(1-dx)*(1-dy)*src_im(y2,x1,:) + dx*(1-dy)*src_im(y2,x2,:) + dx*dy*src_im(y1,x2,:) + (1-dx)*dy*src_im(y1,x1,:);
            B_linear_val=(1-dx)*(1-dy)*src_im(y1,x1,:) + dx*(1-dy)*src_im(y1,x2,:) + dx*dy*src_im(y2,x2,:) + (1-dx)*dy*src_im(y2,x1,:);
            x_new = i+c_offset;
            y_new = j+r_offset;
            if x_new <= 0 || y_new <= 0 || x_new > c || y_new > r
                continue
            end
            I_merged(y_new,x_new,:)=B_linear_val;

        end
    end


end

