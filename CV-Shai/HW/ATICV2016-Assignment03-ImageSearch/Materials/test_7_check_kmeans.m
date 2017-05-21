function test_7_check_kmeans()
    
    clear; clc; dbstop if error;
    
    % Load test data
    [images_brief, code_book_input] = test_init('images_brief', 'code_book');
    
    % Build BRIEF matrix (combine interest point descriptors from images)
    fprintf('Building BRIEF Descriptors matrix... ');
    max_briefs = 5e4; % TEST ONLY PARAMETER. NOT RECOMMENDED VALUE
    brief_mat = extract_briefs(images_brief, max_briefs);
    fprintf('done.\n');
    
    % Run k-means with k input
    fprintf('\nTesting k-means with k input:\n');
    k = 10; % TEST ONLY PARAMETER. NOT RECOMMENDED VALUE
    max_itter = 3; % TEST ONLY PARAMETER. NOT RECOMMENDED VALUE
    [code_book, idx, hdist_mean] = kmeans_hamming(brief_mat, k, max_itter);
    
    % Check results
    assert(size(code_book,1) == k, 'failed size(code_book,1) == k');
    assert(size(code_book,2) == size(brief_mat,2), 'failed size(code_book,2) == size(images_brief,2)');
    assert(numel(unique(idx)) == k, 'failed numel(unique(idx)) == k');
    fprintf('hdist_mean = %0.0f\n', hdist_mean);
    fprintf('Success with k input!\n');
    
    % Run k-means with clusters input
    fprintf('\nTesting k-means with clusters input (might take a while):\n');
    max_itter = 1; % TEST ONLY PARAMETER. NOT RECOMMENDED VALUE
    [code_book, idx, hdist_mean] = kmeans_hamming(brief_mat, code_book_input, max_itter);
    
    % Check results
    assert(size(code_book,1) == size(code_book_input,1), 'failed size(code_book,1) == size(code_book_input,1)');
    assert(size(code_book,2) == size(brief_mat,2), 'failed size(code_book,2) == size(images_brief,2)');
    assert(numel(unique(idx)) <= size(code_book_input,1), 'failed numel(unique(idx)) == k');
    fprintf('hdist_mean = %0.0f\n', hdist_mean);
    fprintf('Success with code_book input!\n');
    
end


function desc_mat = extract_briefs(images_brief, max_briefs)
    
    fns = fieldnames(images_brief);
    
    % Init matrix for all brief descriptors
    num_descriptors = 0;
    for ifn = 1:numel(fns)
        cur_fn = fns{ifn};
        num_descriptors = num_descriptors + size(images_brief.(cur_fn), 1);
    end
    descriptor_size = size(images_brief.(cur_fn), 2);
    descriptor_class = class(images_brief.(cur_fn));
    desc_mat = zeros(num_descriptors, descriptor_size, descriptor_class);
    
    % Extract all descriptors
    row = 0;
    for ifn = 1:numel(fns)
        cur_fn = fns{ifn};
        cur_desc = images_brief.(cur_fn);
        r1 = row + 1;
        r2 = row + size(cur_desc, 1);
        desc_mat(r1:r2, :) = cur_desc;
        row = r2;
    end
    
    % If too many points, shuffle and remove points
    if num_descriptors > max_briefs
        ip = randperm(num_descriptors);
        ip(max_briefs+1:end) = [];
        desc_mat = desc_mat(ip, :);
    end

    % If briefs compressed, extract them
    if isa(desc_mat, 'uint8')
        desc_mat = int2bin(desc_mat);
    end
    
end    

