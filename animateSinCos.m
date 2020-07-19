function animateSinCos
  % Set X domain mesh
  xs = linspace(-2, 2);
  
  % Create the initial Y values for both the sin and cos plots
  phase = 0;
  cosYs = cos(xs - phase);
  sinYs = sin(xs - phase);
  
  %Figure kreieren um sie in M später zu speichern
  f=figure();
  % Plot both the sin and cos on the same axes
  
 
  hCosPlot = plot(xs, cosYs);
  hold on;
  hSinPlot = plot(xs, sinYs);
  i=0;
  %Movie deklarieren
  M(314) = struct('cdata',[],'colormap',[]);
  % Render loop
  while i<314
	 i=i+1;
     % Recompute the sin, cos Ys after incrementing the phase by 0.01
     phase = phase + 0.02;  % Adjust 0.01 to change the perceived animation speed without changing the framerate
     phase = mod(phase, 2*pi); % Keep the phase between [0, 2 pi]
     cosYs = cos(xs - phase);
     sinYs = sin(xs - phase);
     
     % Update the plot YData with these new values. XData stays the same
     hCosPlot.YData = cosYs;
     hSinPlot.YData = sinYs;
     
     % Render the updated values to the screen
	 
     drawnow;
	 hold off
	 M(i)=getframe(gcf);
     hold on
     % Adjust the pause time to change the framerate (within reason).
     %pause(0.005);
  end
  %Movie in .avi Datei Schreiben
  v=VideoWriter("sincos");
  open(v);
  writeVideo(v,M);
  close(v);
end
