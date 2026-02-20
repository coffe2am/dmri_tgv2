function pc=proj_ct(y,beta)
 
pc=y./max(sqrt(dot(y,y,2)),beta)*beta;
end