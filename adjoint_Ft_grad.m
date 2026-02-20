function u_adjoint = adjoint_Ft_grad(Y, s_image)
T = size(Y, 3);
gu_ifft = ifft(Y, [], 3) * sqrt(T);     
u_adjoint = -div_batch(gu_ifft, s_image);  
end
