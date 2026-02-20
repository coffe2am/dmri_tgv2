function ku = MRI_forward_centered(u, sample_matrix)
 
    if isvector(u)
        u = reshape(u, size(sample_matrix));
    end

 
    k_centered = fftshift( fft2( ifftshift(u) ) ) / sqrt(numel(u));

 
    idx = (sample_matrix > 1e-4);
    ku = k_centered(idx);
    ku = ku(:);
end