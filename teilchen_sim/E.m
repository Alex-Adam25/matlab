function [e] = E(p0pos,p1)
	%Efeld ausgehend von einem Teilchen
    p01=p0pos-p1.pos;
    e = p1.cha*((p01/norm(p01))/norm(p01));

end

