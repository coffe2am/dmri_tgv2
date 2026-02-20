function [u_rec,p]=MRI_reconstruction_TGV(s_image,f,sample_matrix,lambda,alpha0,alpha1,sigma,tau)
 
N1=s_image(1); N2=s_image(2);
M=max(size(f,1));

 
u=rand(s_image)+1i*rand(s_image);
 
u=u(:);
u_bar=u;
 
p=rand(N1*N2,2)+1i*rand(N1*N2,2);
p_bar=p;
y1=zeros(M,1);
y2=zeros(N1*N2,2);
y3=zeros(N1*N2,4);

for k=1:1000

    y1=lambda*(y1+sigma*(MRI_forward_centered(u_bar,sample_matrix)-f))/(lambda+sigma);

    y2=proj_ct(y2+sigma*alpha1* (mygrad( u_bar,s_image ) -p_bar),1);

    y3=proj_ct( y3+sigma*alpha0*op_E(p,s_image)  ,1);

    u_1=u;
    temp_uk1=u-tau*( MRI_backward_centered(y1,sample_matrix)-alpha1*div2(y2,s_image) );
    temp_pk1=p+tau*( alpha1*y2 +alpha0*div4(y3,s_image)     );
    u_bar=2*temp_uk1-u;
    p_bar=2*temp_pk1-p;
    u = temp_uk1;
    p = temp_pk1;

    diffe=norm(u-u_1,'fro')/N1*N2;
    if diffe <1e-12

        break;
    end
end
 
u_rec=u;
end


