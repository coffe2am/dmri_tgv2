function xi=v_xi(v,eta,s_image)
 
gv=grad(v,s_image);
xi=gv./(sqrt(dot(gv,gv,2)+eta^2)*[1 1]);
end