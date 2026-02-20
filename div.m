function divh=div(v,sz)
v1=v(:,1);
v2=v(:,2);
N1=sz(1);N2=sz(2);
v1=reshape(v1,N1,N2);
v2=reshape(v2,N1,N2);
gv1=zeros(N1,N2);
gv2=zeros(N1,N2);
gv1(:,1:N2-1)=v1(:,1:N2-1);
gv1(:,2:N2)=gv1(:,2:N2)-v1(:,1:N2-1);
   gv2(1:N1-1,:)=v2(1:N1-1,:);
   gv2(2:N1,:)=gv2(2:N1,:)-v2(1:N1-1,:);
   divh=gv1(:)+gv2(:);
end