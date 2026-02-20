function u = MRI_backward_centered(ku, sample_matrix, make_real)
 

    if nargin < 3, make_real = true; end

    idx = (sample_matrix > 1e-4);
    m = nnz(idx);

    ku = ku(:);
    assert(numel(ku) == m, 'ku length mismatch: expected %d, got %d', m, numel(ku));

 
    k_centered = zeros(size(sample_matrix));
    k_centered(idx) = ku;

 
    u_img = fftshift( ifft2( ifftshift(k_centered) ) ) * sqrt(numel(k_centered));

    u = u_img(:);

    if make_real
        u = real(u);
    end
end