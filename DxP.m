function dxp=DxP(u,sz)
u=reshape(u,sz);
N1=sz(1); N2=sz(2);
dxp=zeros(N1,N2);
 dxp(:, 1:N2-1) = u(:, 2:N2) - u(:, 1:N2-1);
end
