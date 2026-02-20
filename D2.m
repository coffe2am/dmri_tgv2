function d2u=D2(y,xi)

d2u=y-(dot(xi,y,2)*[1 1]).*xi;
end