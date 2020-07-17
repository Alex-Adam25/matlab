classdef Particle
	%Klasse für ein Teilchen
    properties
        pos
        vel
        cha
        mas
        posnew
        force
    end
    methods
        function obj = Particle(pos,vel,cha,mas)
            obj.pos = pos;
            obj.vel = vel;
            obj.cha = cha;
            obj.mas = mas;
        end
        
    end
end

