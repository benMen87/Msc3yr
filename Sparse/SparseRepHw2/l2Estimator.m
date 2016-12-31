function x_hat = l2Estimator(y, C, D)
%L2ESTIMATOR solution to: x_hat = min(||x||_2) s.t. y = CDx_hat
%   use lagrange multipliers eq. loss = ||x||_2 + labda(y - CDx_hat)
%TODO: check whats with A = C*D;

    %inital_x = 1*rand([32^2, 1]); %generate an inital x of mean 0 and var 1

    %  Set options for fminunc
    %options = optimset('GradObj', 'on', 'MaxIter', 400);

    %  Run fminunc to obtain the optimal x
    %  This function will return x and the cost 
    %[xx_hat, cost] = ...
        %fminunc(@(t)(costFunction(t, C, D, y)), inital_x, options);
    %x_hat = A' * (A*A')^-1 * y;
	
    xx_hat = C' * (C*C')^-1 * y;
    x_hat = D' * xx_hat;
end


function [cost, grad] = costFunction(x, C, D, y)
    A = C*D;
    xx = x;
    cost = 0.5*(y - A*xx)'*(y - A*xx) + 0.5*(xx')*xx; 
    grad = C'*(C*xx - y) + xx;
end