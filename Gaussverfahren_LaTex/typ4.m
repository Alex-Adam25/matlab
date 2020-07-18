function [A] = typ4(A,row1,row2)
    A([row1 row2],:)=A([row2 row1],:);
end