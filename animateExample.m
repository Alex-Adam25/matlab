function animateExample
    % Set the mesh size and frame count
    xMeshSz = 150;
    yMeshSz = 250;
    numFrames = 100;

    % You may want to adjust these heuristics which control the x,y,z
    % limits for each frame.
    zMinByFrame = linspace(-1, -1, numFrames);
    yMaxByFrame = 1./(2+0.1*(1:numFrames));
    yMinByFrame = -yMaxByFrame;
    zMaxByFrame = 100./yMaxByFrame;
    xMaxByFrame = 25./zMaxByFrame;
    xMinByFrame = -80./zMaxByFrame;
    
    % Preinitialize a 3D array of frames
    frames = zeros(yMeshSz, xMeshSz, numFrames);
    
    % Pre Compute each frame
    for currFrame = 1:numFrames
        xMin = xMinByFrame(currFrame);
        xMax = xMaxByFrame(currFrame);
        yMin = yMinByFrame(currFrame);
        yMax = yMaxByFrame(currFrame);
        zMax = zMaxByFrame(currFrame);
        zMin = zMinByFrame(currFrame);
        
        % Retrieve the meshing
        xMesh = linspace(xMin, xMax, xMeshSz);
        yMesh = linspace(yMin, yMax, yMeshSz);
        [x,y]=meshgrid(xMesh, yMesh);
        
        % Compute the data M and saturate between zMin and zMax
        M = f(x,y);
        M(M > zMax) = zMax;
        M(M < zMin) = zMin;
        
        % Store the frame in the 3D Array
        frames(:,:,currFrame) = M;
    end

    % Generate an empy mesh object that is stored in the handle
    hMesh = mesh([],[],[], 'FaceColor', 'flat');
    
    % Run the animation
    while true
        for currFrame = 1:numFrames
            xMin = xMinByFrame(currFrame);
            xMax = xMaxByFrame(currFrame);
            yMin = yMinByFrame(currFrame);
            yMax = yMaxByFrame(currFrame);
            zMax = zMaxByFrame(currFrame);
            zMin = zMinByFrame(currFrame);

            xMesh = linspace(xMin, xMax, xMeshSz);
            yMesh = linspace(yMin, yMax, yMeshSz);

            % Set the data in the mesh handle.
            hMesh.XData = xMesh;
            hMesh.YData = yMesh;
            hMesh.ZData = frames(:,:,currFrame);
            
            % Set the x,y,z range
            hMesh.Parent.XLim = [xMin, xMax];
            hMesh.Parent.YLim = [yMin, yMax];
            hMesh.Parent.ZLim = [zMin, zMax];
            
            % drawnow tells the figure to display the changes.
            drawnow;
            
            % Pause execution to produce a smooth animation
            pause(0.01);
        end
    end
end

% The function to plot
function w = f(x, y) 
    z = complex(x, y);
    w = 1./(z.^2 .* (1 + exp(1./z)));
    w = abs(w);
end