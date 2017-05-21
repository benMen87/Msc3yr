function ints = bin2int(bins)
    % Converts matrix of binary values to matrix of uint8 integers,
    % assigning binaries bit-wise into integers.
    % Each line of binaries converts to line of integers.
    %
    % ints = BIN2INT(bins)
    %
    % INPUT:
    % -------
    % bins - NxB matrix of type logical (binary), where N is number of
    %        points and B is number of binary values per point.
    %
    % OUTPUT:
    % --------
    % ints - NxL matrix of type uint8, where N is number of
    %        points and L is number of int values per point.
    %        L = ceil(B/8).
    %
    % =======================
    % Created by: Alex Rakita
    % =======================
    
    % Check that the input is of the right type
    assert(islogical(bins), 'CVApps:InputCheck:WrongInputType', 'Input BINS must be of logical type.');

    word_size = 8;
    
    % Extract sizes
    num_points = size(bins, 1);
    num_bits = size(bins, 2);
    num_words = ceil(num_bits / word_size);
    
    % Init outputs
    ints = zeros(num_points, num_words, 'uint8');
    pows = uint8(0:7);
    
    % Calculate outpus
    pows_vec = repmat(2 .^ pows, 1, num_words);
    pows_vec = pows_vec(1:num_bits);
    pows_mat = repmat(pows_vec, num_points, 1);
    pows_mat(~bins) = 0;
    for iw = 1:num_words
        c1 = (iw-1)*word_size + 1;
        c2 = min(iw*word_size, num_bits);
        ints(:, iw) =  sum(pows_mat(:, c1:c2), 2);
    end
end