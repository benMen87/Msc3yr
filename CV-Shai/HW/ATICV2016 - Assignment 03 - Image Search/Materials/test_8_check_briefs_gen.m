function test_8_check_briefs_gen()
    
    clear; clc; dbstop if error;
    
    num_brief_pairs = 1024; % TEST ONLY PARAMETER. NOT RECOMMENDED VALUE
    win_size = 10; % TEST ONLY PARAMETER. NOT RECOMMENDED VALUE
    
    for k=1:100
        
        % Generate coordinates
        brief_coord = generate_brief_coordinates(num_brief_pairs, win_size);
        
        % Check results
        assert(size(brief_coord, 1) == 4, 'Result must have 4 rows!');
        assert(size(brief_coord, 2) == num_brief_pairs, 'Result must have ''num_brief_pairs'' columns!');
        assert(all(brief_coord(:)) <= win_size, 'All coordinates must be within window!')
        
    end
    
    fprintf('Test succeeded!\n')
    
end