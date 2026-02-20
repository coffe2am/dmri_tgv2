function gu=grad(u,s_image)
 
u=reshape(u,s_image);
gu=zeros([s_image 2]);
gu(:,1:s_image(2)-1,1)=u(:,2:s_image(2))-u(:,1:s_image(2)-1);
gu(1:s_image(1)-1,:,2)=u(2:s_image(1),:)-u(1:s_image(1)-1,:);
gu=reshape(gu,[],2);
end

