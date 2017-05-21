function bins = int2bin(ints, num_bits)
    % Converts matrix of uint8 integers to matrix of binary values,
    % extracting binaries bit-wise from integers.
    % Each line of integers converts to line of binaries.
    %
    % bins = INT2BIN(ints, [num_bits])
    %
    % INPUT:
    % -------
    % ints - NxL matrix of type uint8, where N is number of
    %        points and L is number of int values per point.
    % num_bits - Defines the number 
    %
    % OUTPUT:
    % --------
    % bins - NxB matrix of type logical (binary), where N is number of
    %        points and B is number of binary values per point.
    %        If num_bits inputed, B = num_bits.
    %        Otherwise, B <= 8*L (Removes end bits if equals to 0 for all N)
    %
    % =======================
    % Created by: Alex Rakita
    % =======================
    
    % Check that the input is of the right type
    assert(isa(ints, 'uint8'), 'CVApps:InputCheck:WrongInputType', 'Input INTS must be of uint8 type.');
    
    word_size = 8;
        
    % Extract sizes
    num_points = size(ints, 1);
    num_words = size(ints, 2);
    
    % Handle optional inputs
    if nargin < 2 || isempty(num_bits)
        preset_num_bits = false;
        num_bits = num_words * word_size;
    else
        preset_num_bits = true;
    end

    % Init outputs and stuff
    bins = false(num_points, num_bits);
    
    % Convert integers to bits
    bitnum = 1:word_size;
    bitnum_mat = repmat(bitnum, num_points, 1);
    for iw = 1:num_words
        word_mat = repmat(ints(:,iw), 1, word_size);
        c1 = (iw-1)*word_size + 1;
        c2 = iw*word_size;
        bins(:, c1:c2) = bitget(word_mat, bitnum_mat);
    end
    
    % Remove redundant bits
    if not(preset_num_bits)
        while ~any(bins(:,num_bits))
            num_bits = num_bits - 1;
        end
        bins = bins(:, 1:num_bits);
    end
end