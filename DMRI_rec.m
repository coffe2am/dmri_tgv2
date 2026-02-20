function [u_rec ]=DMRI_rec(u0,u_initial,f,sample_matrix,eta,sigma,tau,alpha,beta,gamma,A) 
[N1,N2,T]=size(sample_matrix);
s_image = [N1 N2];
wu=zeros(N1*N2,T);
xi=zeros(N1*N2,2,T);
for t=1:T
    wu(:,t)=w_u(u0(:,t),eta,s_image);
    xi(:,:,t)=v_xi(u0(:,t),eta,s_image);

end 
w2=randn(N1*N2,2,T);
w2_bar=w2;
w21=w2;
w1=randn(N1*N2,2,T);
w1_bar=w1;
w11=w1;
S=u_initial;
S1=S;
S_bar=S1;
R=randn(size(S));
R1=R;R_bar=R;
alpha0=A(1);alpha1=A(2);
y1 = cell(T, 1);
for t = 1:T
    y1{t} = randn(size(f{t}));
end
y2=randn(N1*N2,2,T);
y3=randn(N1*N2,4,T);
y4=randn(N1*N2,2,T);
y5=randn(N1*N2,4,T);
y6=randn(N1*N2,2,T);
for k=1:5000
    u_1=S+R;
    for t=1:T
        y1{t}=alpha*(y1{t}+sigma*(MRI_forward_centered(S_bar(:,t)+R_bar(:,t),sample_matrix(:,:,t))-f{t}))/(alpha+sigma);
        y2(:,:,t)=proj_ct(  y2(:,:,t)+sigma*beta*alpha1*( D1( grad(S_bar(:,t),s_image) ,wu(:,t) )-w1_bar(:,:,t) )  ,1);
        y3(:,:,t)=proj_ct( y3(:,:,t)+sigma*beta*alpha0*op_E(w1_bar(:,:,t),s_image) ,1);
        y4(:,:,t)=proj_ct(  y4(:,:,t)+sigma*beta*alpha1*( D2( grad(S_bar(:,t),s_image) ,xi(:,:,t) )-w2_bar(:,:,t) )  ,1);
        y5(:,:,t)=proj_ct( y5(:,:,t)+sigma*beta*alpha0*op_E(w2_bar(:,:,t),s_image) ,1);
    end
    y6 = proj_ct_3d(y6+sigma*gamma*(Ft_grad(R_bar,s_image)), 1);
    for t=1:T
        S1(:,t)=S(:,t)-tau*(  MRI_backward_centered(y1{t},sample_matrix(:,:,t))         ...
            -beta*alpha1*div(D1(y2(:,:,t),wu(:,t)) ,s_image) ...
            -beta*alpha1*div(D2(y4(:,:,t),xi(:,:,t)) ,s_image)  );
        R1(:,t)=R(:,t)-tau*(  MRI_backward_centered(y1{t},sample_matrix(:,:,t)) );
        w11(:,:,t)=w1(:,:,t)+tau*beta*( alpha1*y2(:,:,t)+alpha0*div4(y3(:,:,t),s_image)   );
        w21(:,:,t)=w2(:,:,t)+tau*beta*( alpha1*y4(:,:,t)+alpha0*div4(y5(:,:,t),s_image)   );

    end
    R1=R1-tau*gamma*adjoint_Ft_grad(y6,s_image);
    S_bar=2*S1-S;
    S = S1;
    w1_bar = 2*w11 -w1;
    w1=w11;
    w2_bar=2*w21-w2;
    w2 = w21;
    R_bar=2*R1-R;
    R = R1;
    diffe=norm((S+R)-(u_1),'fro')/norm((u_1) ,'fro');
    if diffe < 1e-5
        break;
    end
end


u_rec=S+R;
end


