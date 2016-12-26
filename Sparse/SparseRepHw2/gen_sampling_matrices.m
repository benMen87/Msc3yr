<<<<<<< HEAD
function [Cd, Cg, Cb] = gen_sampling_matrices(s, p, D)
    assert( p <= 1, ...
        'p is the fraction of s rows thus must be smaller than 1');
        %Verify No atoms are zeroed
    i = 0;
	while (true)
    	Cd = gen_Cd(s, p);
	    A = Cd*D;
	    if find(~any(all(A == 0)))
		    break;
            disp('Done!!');
	    end
        i = i + 1;
        if mod(i, 50) == 0
            disp(sprintf('try # %d', i));
        end
    endwhile
    Cg = gen_Cg(s, p);
    Cb = gen_Cb(s);
end


function [C_d]  =  gen_Cd(s, p)
    assert( p <= 1, ...
        'p is the fraction of s rows thus must be smaller than 1');
    l = 32;
    n = s^2;
	v = [ones(1,l) / l, zeros(1,s-l)];
    m = floor(p * s^2);
	M = sparse(toeplitz(v,v));

	C_a = kron(M,M);
	C_d = eye(n);
    C_d = C_d(sort(randperm(n,  m)), :);
	C_d = sparse(C_d*C_a);
end

function Cg = gen_Cg(s, p)
    assert( p <= 1, ...
        'p is the fraction of s rows thus must be smaller than 1');

    m = floor(p * s^2);
    n = s^2;
    mu  = 0;
    sigma = 1;

    Cg = sparse(sigma*randn([m, n]) + mu);

end

function Cb = gen_Cb(s)
    %Half of an 11 tap Gaussian filter:
    v = exp(-0.5*(0:5).^2);
    %Normalize:
    v = v/(v(1) + 2*sum(v(2:end)));
    %Create the 1-D filter matrix of size sxs:
    M = sparse(toeplitz([v, zeros(1,s-numel(v))],[v, zeros(1,s-numel(v))]));
    %Create the 2-D vector form blur operator:
    Cb = kron(M,M);
end 