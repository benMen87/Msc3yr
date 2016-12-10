function [ FM_IM ] = forward_mapping(src_im,H)
    s_src_rows=size(src_im,1);
    s_src_columns=size(src_im,2);
    % find grid of the new image:
    p1=H*[1,1,1]';
    p2=H*[1,s_src_rows,1]';
    p3=H*[s_src_columns, 1,1]';
    p4=H*[s_src_columns, s_src_rows, 1]';
    
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
    
    % the new image size:
    rows=x_max-x_min+1;
    columns=y_max-y_min+1;
    FM_IM = uint8(zeros(columns,rows,3));
    imshow(FM_IM)
    
    % calculate the new image:
    for i=1:s_src_rows
        for j=1:s_src_columns
            temp_index=H*[j,i,1]';
            index=floor([temp_index(1)/temp_index(3), temp_index(2)/temp_index(3)]);
            x=index(1)-x_min+1;
            y=index(2)-y_min+1;
            FM_IM(y,x,:)=src_im(i,j,:);
        end
    end
       
end

