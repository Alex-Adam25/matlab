function [A] = typ3(A,origin,mult,target)
    A(target,:)=A(target,:)+A(origin,:).*mult;
end