%Geometrische Größen zur Positonierung der teilchen
a=20;
b=15;

%Erstellen der Teilchen
par=[Particle([0 0]+b,[0 0],1,1) Particle([a 0]+b,[0 0],1,1) Particle([0.5*a 3^(0.5)*0.5*a]+b,[0 0],-1,1)];
%par=[Particle([40 10],[0 0],1,1)];

%Festlegen der Colormap(Farbe)
colormap(redblue)

%erster Durchlauf
[Z,par] = bild(par,40);
pcolor(Z);

%Festlegung der Ploteigenschaften
axis tight manual
ax = gca;
ax.NextPlot = 'replaceChildren';
colorbar
caxis([-1 1])
hold on

%Anzahl der Frames(100 kann gespeichert werden(ka warum 10 nicht))
loops = 100;

%Mögliche höhere Auflösung
% f=gcf;
% f.Position = [200 200 720 720];

%Vorbereiten der mp4 Datei
F(loops) = struct('cdata',[],'colormap',[]);
set(gcf, 'renderer', 'zbuffer');

%Aufnehen eines Wertes zum anzeigen in der Animation
forcepositivy=zeros(loops,1);

for i = 1:loops 
	%Aktl Frame count
    disp(i)
	%Daten Generieren 
    [Z,par] = bild(par,50);
	%Zeichnen
    pcolor(Z)
	%Wert aufnehmen
    forcepositivy(i)=par(1).force(1);
	%Beschriftung
    caption = sprintf('F.y(unten links) = %.5f',par(1).force(1));
    title(caption, 'FontSize', 15);
	drawnow
    %Frame für diemp4 grabben
    F(i) = getframe(gcf);
end

%Speicherprozess einleiten
promptMessage = sprintf('save?');
titleBarCaption = 'Continue?';
button = questdlg(promptMessage, titleBarCaption, 'Yes', 'No', 'Yes');
if strcmpi(button, 'yes')
    defaultFileName = {'*.mp4'};
    [baseFileName, folder] = uiputfile(defaultFileName, 'Specify a file');
    if baseFileName == 0
		% User clicked the Cancel button.
		return;
    end
    fullFileName = fullfile(folder, baseFileName);
    [folder, baseFileName, ext] = fileparts(fullFileName);
    writerObj = VideoWriter(fullFileName, 'MPEG-4');
    open(writerObj);
    writeVideo(writerObj,F)
    close(writerObj)
end
