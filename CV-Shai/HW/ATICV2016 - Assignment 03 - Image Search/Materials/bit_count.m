function bc = bit_count(ints)
    % Counts bit-wise the number of 'ON' bits along each line of ints.
    %
    % bc = BIT_COUNT(ints)
    %
    % INPUT:
    % -------
    % ints - NxL matrix of type uint8, where N is number of
    %        points and L is number of int values per point.
    %
    % OUTPUT:
    % --------
    % bc - Nx1 vector indicating number of 'ON' bits along each line of
    %      the input.
    %
    % =======================
    % Created by: Alex Rakita
    % =======================

    % Check that input is of the right type
    assert(isa(ints, 'uint8'), 'CVApps:InputCheck:WrongInputType', 'Input INTS must be of uint8 type.');
    
    % Preload lookup table
    persistent lookup_table
    if isempty(lookup_table)
        lookup_table = uint32(sum(dec2bin(0:255) - '0', 2))';
    end
    
    % Count on bits for each word
    indxs = uint16(ints) + uint16(1);
    bc_mat = lookup_table(indxs);
    
    % Sum on words each row
    bc = sum(bc_mat, 2);
    
end