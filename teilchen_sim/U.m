function [u] = U(p0pos,p1)
	%Potenzialfeld ausgehend von einem Teilchen
    p01=norm(p0pos-p1.pos);
    if p01==0
        u=0;
    else
        u = p1.cha/norm(p01);
    end
end

