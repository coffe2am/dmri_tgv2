function G = Ft_grad(U, s_image)
T = size(U, 2);
gu = grad_batch(U, s_image);        
G = fft(gu, [], 3) / sqrt(T);
end
