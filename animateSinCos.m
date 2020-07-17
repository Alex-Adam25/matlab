function animateSinCos
  % Set X domain mesh
  xs = linspace(-2, 2);
  
  % Create the initial Y values for both the sin and cos plots
  phase = 0;
  cosYs = cos(xs - phase);
  sinYs = sin(xs - phase);
  
  % Plot both the sin and cos on the same axes
  hCosPlot = plot(xs, cosYs);
  hold on;
  hSinPlot = plot(xs, sinYs);
  
  % Render loop
  while true
     % Recompute the sin, cos Ys after incrementing the phase by 0.01
     phase = phase + 0.01;  % Adjust 0.01 to change the perceived animation speed without changing the framerate
     phase = mod(phase, 2*pi); % Keep the phase between [0, 2 pi]
     cosYs = cos(xs - phase);
     sinYs = sin(xs - phase);
     
     % Update the plot YData with these new values. XData stays the same
     hCosPlot.YData = cosYs;
     hSinPlot.YData = sinYs;
     
     % Render the updated values to the screen
     drawnow;
     
     % Adjust the pause time to change the framerate (within reason).
     %pause(0.005);
  end
end