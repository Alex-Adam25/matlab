clear
%Laden der Matrixen
la
mat=lamat1;
[mmat,nmat]=size(mat);

%bild=zeros([mmat,nmat]);
%Keinste dim bzw n oder m finden
dim=min(size(mat));
%bild zeichnet die schrittee der rechung auf
bildindex=0;
%Berechent die r ZSM durch Itteration 
for index = 1:dim
    %Nimmt sich eine immerkleiner werdene Matrix herraus und erzielt dass
    %alles 0 außer die stufe wird. Stufe wird 1
    A = mat(index:end,index:end);
    
    %Check ob es die Nullmatrix ist.Falls ja fertig
    if nnz(A) == 0
        break
    end
    %Nimmt ein bild der Akuellen matrix
    bildindex=bildindex+1;
    bild(:,:,bildindex)=mat;
    
    %bestimmt die größe der Herrausgeschnittenen Matrix
    [m,n]=size(A);
    
    %erstes nicht leere col finden
    for col = 1:n
        if A(:,col)~=0
            j=col;
            break
        end
    end
    
    %erstes nicht element im col finden
    for row = 1:m
        if A(row,j) ~= 0
            i=row;
            break
        end
    end
    
    %mit dem inversen mult
    A=typ1(A,i,A(i,j)^-1);
    %mit der ersten row vertauschen
    A=typ4(A,1,i);
    
    %Nimmt ein bild der Akuellen matrix
    bildindex=bildindex+1;
    bild(:,:,bildindex)=mat;
    %setzt A in das aufgenommene Bild ein
    bild(index:end,index:end,bildindex) = A;

    %Setzt alle außer die stufe Null
    for row = 2:m
        A=typ3(A,1,-A(row,j),row);
    end
    
    %setzt A in die Matrix ein
    mat(index:end,index:end) = A;
end
%Nimmt ein Bild der finalen Matrix 
bildindex=bildindex+1;
bild(:,:,bildindex)=mat;

%Findet die Row welche nicht 0 ist und in dieser die Stufe
%ist gleich der letzten Stufe
found=false;
for i=0:(mmat-1)
    for j=1:nmat
        if mat((mmat-i),j)~=0 && found==false
            si=(mmat-i);
            sj=j;
            found=true;
        end
    end
end

%Setzt alle elemente über allen Stufe 0
for index=1:(min([si sj])-1)
    %Setzt alle werte über der Stufe 0
    for i=1:((si)-1)
        mat=typ3(mat,si,-mat(i,sj),i);
    end
    %Wählt die Nächste kleiner Stufe aus
    si=si-1;
    sj=sj-1;
    %Nimmt ein Bild 
    bildindex=bildindex+1;
    bild(:,:,bildindex)=mat;
end
%deklariert einen String in welchen alle Bilder in Latex form beschreiben
%werden
latexstr="";

%Definiert nach wievielen Matritzen ein Umbruch kommt
breakpoint=2;

%Setzt alle floating point fehler 0
bild(abs(bild(:,:,:))<10^(-10))= 0;

%Definiert ob es Brüche oder Decimal(4stellen) seien Sollen
frac=false;
if frac
    sympref('FloatingPointOutput',false);
else
    sympref('FloatingPointOutput',true);
end
latexstr=append(latexstr,"\begin{document}\begin{align*}");
for i = 1:(bildindex-1)
%    Fügt die Matrix an den str an
%    Latex implementation
%    latexstr=append(latexstr,latex(sym(bild(:,:,i))),"\rightarrow");

%    eigene Implementation:
    if mod(i,breakpoint)==1
        latexstr=append(latexstr,mattolat(bild(:,:,i)),"&\rightsquigarrow");
        continue
    end
    latexstr=append(latexstr,mattolat(bild(:,:,i)),"\rightsquigarrow");

    %Setzt einen Zeilenumbruch
    if mod(i,breakpoint)==0
        latexstr=append(latexstr,"\\");
    end
end
%um den letzten rightsquigarrow zu vermeiden
latexstr=append(latexstr,mattolat(bild(:,:,bildindex)));
latexstr=append(latexstr,"\end{align*}\end{document}");

