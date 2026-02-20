function dyn = DyN(u,sz)
   u=reshape(u,sz);
N1=sz(1); N2=sz(2);
dyn=zeros(N1,N2);
 
   dyn(1:N1-1,:)=u(1:N1-1,:);
   dyn(2:N1,:)=dyn(2:N1,:)-u(1:N1-1,:);
end
