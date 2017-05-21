function [ H ] = compute_homography_naive(mp_src, mp_dst)
    N=size(mp_src,2);
    % calculating Matrix A
    A=zeros(2*N, 9);
    A(1:2:2*N,1:2)=mp_src'; %columns 1-2
    A(1:2:2*N,3)=ones(N,1); % column 3
    A(2:2:2*N,4:5)=mp_src'; %columns 4-5
    A(2:2:2*N,6)=ones(N,1); % column 6
    A(1:2:2*N,7)=-mp_src(1,:)'.*mp_dst(1,:)'; % column 7 odd rows
    A(2:2:2*N,7)=-mp_src(1,:)'.*mp_dst(2,:)'; % column 7 even rows
    A(1:2:2*N,8)=-mp_src(2,:)'.*mp_dst(1,:)'; % column 8 odd rows
    A(2:2:2*N,8)=-mp_src(2,:)'.*mp_dst(2,:)'; % column 8 even rows
    A(:,9)=-mp_dst(:); %column 9
    
    
    [U, S, V] = svd(A,0);
    X = V(:,end);
    H = reshape(X,3,3)';
  




end

