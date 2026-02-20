function wu=w_u(u,eta,s_image)
 
gu=grad(u,s_image);
wu=eta./sqrt(dot(gu,gu,2)+eta^2);
end