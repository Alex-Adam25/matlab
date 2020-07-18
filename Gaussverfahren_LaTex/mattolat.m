function [code] = mattolat(matrix)
% Latex dependencys:

% \usepackage{amsmath,amssymb}
% 
% %Für erweiterte Koeffizietenmatrizen
% \makeatletter
% \renewcommand*\env@matrix[1][*\c@MaxMatrixCols c]{%
%   \hskip -\arraycolsep
%   \let\@ifnextchar\new@ifnextchar
%   \array{#1}}

%     Matrix Dimensionen bestimmen
    [m,n]=size(matrix);
%     Leeren string deklarieren
    code="";
%     Beginn der p-matrix
    code=append(code,"\begin{pmatrix}[");
%     rechtsbündig machen und b vektor abtrennen 
    for i = 1:(n-1)
        code=append(code,"r");
    end
    code=append(code,"|r]");
%     Zeilen und spallen der Matrix füllen

    for i = 1:m
        for j = 1:(n-1)
            code=append(code,num2str(matrix(i,j)),"&");
        end     
        code=append(code,num2str(matrix(i,n)));
        code=append(code,"\\");
    end
    code=append(code,"\end{pmatrix}");
end

