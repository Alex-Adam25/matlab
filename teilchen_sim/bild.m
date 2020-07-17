function [bild,par] = bild(par,pix)
%par=Array der Teilchen (wird aktualisiert)
%pix=anzahl der x und y pixel (resultiert im Quadrat)
%bild=Potenzelle Energie an jedem Ort

	%Erlaubt das Rendern des Frames x mal zu Überspringen
    skip=1;
	
    arr=zeros(pix,pix);
for i = 1:skip
    for p = 1:length(par)
        fsum=[0 0];
        for P = 1:length(par)
            fsum=fsum+Fc(par(p),par(P));
        end
        par(p).force=fsum;
        par(p).vel=par(p).vel+fsum./par(p).mas;
        par(p).posnew=par(p).pos+par(p).vel;
    end
    for p = 1:length(par)
        par(p).pos=par(p).posnew;
    end
end

for x = 1:pix
    for y = 1:pix
        Usum=0;
        for p = 1:length(par)
            Usum=Usum+U([x y],par(p));
        end
        arr(x,y)=Usum;
    end
end
bild=arr;
end
