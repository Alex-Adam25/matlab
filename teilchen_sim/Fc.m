function [force] = Fc(p0,p1)
	%Kraft auf ein Teilchen
    p01=p0.pos-p1.pos;
    r=norm(p01);
    if r > 0
        force = p0.cha*p1.cha*((p01/r)/r^2);
    else 
        force=0;
    end
end

