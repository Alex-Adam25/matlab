function EP2_Transmittanz
  Aein=1;
  k1=1;
  w=1;
  k2=2;
  % Set X domain mesh
  xm = linspace(-2*pi, 0);
  xp = linspace(0,2*pi);
  % Create the initial Y values for both the sin and cos plots
  t=0;
  yein= Aein.*cos(k1.*xm-w*t);
  yrefl=Aein.*(k1-k2)/(k1+k2).*cos(k1.*xm+w*t);
  ysuper=yein+yrefl;
  ytrans=Aein.*(1+(k1-k2)/(k1+k2)).*cos(k2.*xp-w*t);
  % Plot everything on the same axes
  hyeinP = plot(xm, yein,'LineWidth',3);
  hold on;
  hyreflP = plot(xm, yrefl,'LineWidth',3);
  hysuperP = plot(xm, ysuper,'LineWidth',3);
  hytransP = plot(xp, ytrans,'LineWidth',3);
  xlim([-2*pi 2*pi]);
  ylim([-2 2]);
  % Render 
  for i =1:10000
	 
     % Recompute the sins Ys after incrementing the time
	 t=t+0.1;
	 title(num2str(i));
	 yein= Aein.*cos(k1.*xm-w*t);
     yrefl=Aein.*(k1-k2)/(k1+k2).*cos(k1.*xm+w*t);
	 ysuper=yein+yrefl;
	 ytrans=Aein.*(1+(k1-k2)/(k1+k2)).*cos(k2.*xp-w*t);

     % Update the plot YData with these new values. XData stays the same
     hyeinP.YData = yein;
	 %hyeinP.Color = [abs(sin(i*0.2+pi/3)) abs(cos(i*0.1)) abs(sin(i*0.4))];
	 %hyeinP.LineWidth = abs(sin(i*0.1))*10;
	 
	 hyreflP.YData = yrefl;
	 %hyreflP.Color = [abs(sin(i*0.2+pi/3)) abs(cos(i*0.3)) abs(sin(i*0.4))];
	 %hyreflP.LineWidth = abs(sin(i*0.1+pi/2))*30;
	 
	 hysuperP.YData = ysuper;
	 %hysuperP.Color = [abs(sin(i*0.2+pi/2)) abs(cos(i*0.2)) abs(sin(i*0.4))];
	 hytransP.YData = ytrans;
	 %hytransP.Color = [abs(sin(i*0.2+pi/6)) abs(cos(i*0.5)) abs(sin(i*0.4))];
     % Render the updated values to the screen
     drawnow;
     % Adjust the pause time to change the framerate (within reason).
     pause(0.025);
  end
end
