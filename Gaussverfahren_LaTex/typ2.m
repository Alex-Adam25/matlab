function [A] = typ2(A,origin,target)
    A(target,:)=A(target,:)+A(origin,:);
end