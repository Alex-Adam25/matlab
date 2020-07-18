function [A] = typ1(A,row,mult)
    A(row,:)=A(row,:).*mult;
end