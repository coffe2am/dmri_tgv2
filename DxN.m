function dxn = DxN(u,sz)
   u=reshape(u,sz);
N1=sz(1); N2=sz(2);
dxn=zeros(N1,N2);
 
   dxn(:,1:N2-1)=u(:,1:N2-1);
   dxn(:,2:N2)=dxn(:,2:N2)-u(:,1:N2-1);
end