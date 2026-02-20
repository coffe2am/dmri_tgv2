function pc=proj_ct_3d(y,beta)
  
pc=y./max(abs(y),beta)*beta;
end