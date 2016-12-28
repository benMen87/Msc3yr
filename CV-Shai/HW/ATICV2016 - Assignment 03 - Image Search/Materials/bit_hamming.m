function hdist = bit_hamming(x,y)
    % Finds the bit-wise hamming distance between each X row to each Y row
    %
    % hdist = BIT_HAMMING(x,y)
    %
    % INPUTS:
    % -------
    % x - MxW matrix of type uint8, with M points and W words per point.
    %     Each row of x corresponts to a single point.
    % y - NxW matrix of type uint8, with N points and W words per point.
    %     Each row of y corresponts to a single point.
    %
    % OUTPUT:
    % --------
    % hdist - MxN matrix indicating the bit-wise hamming distance
    %         between each x to each y.
    %         hdist(m,n) = bit_hamming(x(m,:), y(n,:)).
    % 
    % Notes:
    % ------
    % 1. The bit-wise hamming distance between two WORDS counts the
    %    number of different bits between the words.
    %    For uint8, this distance can be between 0 and 8.
    %
    % 2. The bit-wise hamming distance between two POINTS (with each
    %    point represented with W words) sums the bit-wise hamming
    %    distances between corresponding words of the points.
    %    For W-word uint8, this distance can be between 0 and 8*W.
    %
    % =======================
    % Created by: Alex Rakita
    % =======================
    
    % Check that inputs are correct
    assert(isa(x, 'uint8'), 'CVApps:InputCheck:WrongInputType', 'Input X must be of uint8 type.');
    assert(isa(y, 'uint8'), 'CVApps:InputCheck:WrongInputType', 'Input Y must be of uint8 type.');
    assert(size(x,2) == size(y,2), 'CVApps:InputCheck:BadInput', 'Both X and Y must have same number of words per row.');

    % Init and check inputs
    nx = size(x,1);
    ny = size(y,1);
    
    if nx == 0 || ny == 0
        % If any of inputs is empty matrix
        hdist = zeros(nx, ny);
        
    elseif nx == 1 && ny == 1
        % Both singletons
        hdist = bit_count(bitxor(x,y));
        
    elseif nx == 1
        % Only X is singleton
        hdist = bit_count(bsxfun(@bitxor, x, y))';
        
    elseif ny == 1
        % Only Y is singleton
        hdist = bit_count(bsxfun(@bitxor, x, y));
        
    else
        % Both inputs are full matrices
        
        hdist = zeros(nx, ny);
        
        % Loop over the smaller input
        if nx >= ny
            for k = 1:ny
                hdist(:,k) = bit_hamming(x,y(k,:));
            end
        else
            for k = 1:nx
                hdist(k,:) = bit_hamming(x(k,:),y);
            end
        end
        
    end
end
