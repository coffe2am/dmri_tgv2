function ehv=op_E(v,sz)
N1=sz(1); N2=sz(2);
ehv=zeros(N1*N2,4);
ehv11=DxN(v(:,1),sz);
ehv12=1/2*(DyN(v(:,1),sz) + DxN(v(:,2),sz) );
ehv22=DyN(v(:,2),sz);
ehv(:,1)=ehv11(:);
ehv(:,2)=ehv12(:);
ehv(:,3)=ehv12(:);
ehv(:,4)=ehv22(:);
end