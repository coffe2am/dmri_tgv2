function divh=div4(w,sz)
 

N1=sz(1); N2=sz(2);
divh=zeros(N1*N2,2);
w11=w(:,1);
w12=w(:,2);
 
w22=w(:,4);
 
gxw11=DxP(w11,sz);
gyw12=DyP(w12,sz);
gxw12=DxP(w12,sz);
gyw22=DyP(w22,sz);
divh(:,1)=gxw11(:)+gyw12(:);
divh(:,2)=gxw12(:)+gyw22(:);
end