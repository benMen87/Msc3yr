function hdist = dist_hamming(x,y)
    % Finds the hamming distance between each X row to each Y row
    %
    % hdist = DIST_HAMMING(x,y)
    %
    % INPUTS:
    % -------
    % x - MxB matrix of type logical, with M points and B binaries per point.
    %     Each row of x corresponts to a single point.
    % y - NxB matrix of type logical, with N points and B binaries per point.
    %     Each row of y corresponts to a single point.
    %
    % OUTPUT:
    % --------
    % hdist - MxN matrix indicating the hamming distance between each
    %         x to each y.
    %         hdist(m,n) = dist_hamming(x(m,:), y(n,:)) = 
    %                    = sum(xor(x(m,:), y(n,:)))
    % Notes:
    % ------
    % 1. The hamming distance between two POINTS (with each point 
    %    represented with B bits) counts the number of different
    %    corresponding bits between the two points.
    %    The distance can receive values between 0 and B.
    %
    % =======================
    % Created by: Alex Rakita
    % =======================
    
    % Check that inputs are correct
    assert(isa(x, 'logical'), 'CVApps:InputCheck:WrongInputType', 'Input X must be of logical type.');
    assert(isa(y, 'logical'), 'CVApps:InputCheck:WrongInputType', 'Input Y must be of logical type.');
    assert(size(x,2) == size(y,2), 'CVApps:InputCheck:BadInput', 'Both X and Y must have same number of words per row.');

    % Init and check inputs
    nx = size(x,1);
    ny = size(y,1);
    
    if nx == 0 || ny == 0
        % If any of inputs is empty matrix
        hdist = zeros(nx, ny);
        
    elseif nx == 1 && ny == 1
        % Both singletons
        hdist = sum(xor(x,y), 2);
        
    elseif nx == 1
        % Only X is singleton
        hdist = sum(bsxfun(@xor, x, y), 2)';
        
    elseif ny == 1
        % Only Y is singleton
        hdist = sum(bsxfun(@xor, x, y), 2);
        
    else
        % Both inputs are full matrices
        
        hdist = zeros(nx, ny);
        
        % Loop over the smaller input
        if nx >= ny
            for k = 1:ny
                hdist(:,k) = dist_hamming(x,y(k,:));
            end
        else
            for k = 1:nx
                hdist(k,:) = dist_hamming(x(k,:),y);
            end
        end
        
    end
end
