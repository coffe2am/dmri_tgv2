function dyp=DyP(u,sz)
u=reshape(u,sz);
N1=sz(1); N2=sz(2);
dyp=zeros(N1,N2);
dyp(1:N1-1, :) = u(2:N1, :) - u(1:N1-1, :);
end
