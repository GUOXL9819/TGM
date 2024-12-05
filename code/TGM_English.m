function [outputArg1, outputArg2] = TGM_English(im, x)
    % Determine the critical gradient. 
    % x = 1 for open sea, x = 2 for bay, x = 3 for lake
    switch x
        case 1
            K = 0.0022;
        case 2
            K = 0.0011;
        case 3
            K = 0.0013;
    end

    % Calculate temperature gradient
    [xx, yy] = meshgrid(1:size(im, 2), 1:size(im, 1));
    TT = im;
    TT1 = TT;
    [px, py] = gradient(TT1);
    % 30 is the resolution of the image
    px = px / 30;
    py = -py / 30;
    pp = sqrt(px.^2 + py.^2);
    
    % Draw contour of the temperature gradient and close the plot
    [c, h] = contour3(xx, yy, pp, [K K], 'r');
    close
    
    % Calculate background temperature
    A = {};
    k = 1;
    i = 1;
    AA = [];
    while i < size(c, 2)
        A{k,1} = c([1, 2], i+1:i+c(2, i));
        A{k,2} = size(A{k,1}, 2);
        AA(k, 1) = size(A{k,1}, 2);
        i = i + c(2, i) + 1;
        k = k + 1;
    end
    
    [tblB, index] = sortrows(AA, 'descend');
    B = A(index, :);
    
    % Limit the number of regions processed
    maxRegions = min(5, size(B, 1));
    
    % Buffer the polygons and calculate union
    polyout1sum = [];
    for i = 1:maxRegions
        P{i,2} = polybuffer(B{i,1}', 'lines', 3);
        if isempty(polyout1sum)
            polyout1sum = P{i,2};
        else
            polyout1sum = union(polyout1sum, P{i,2});
        end
    end

    % Initialize in-polygon matrix
    in = NaN(size(TT1));

    % Check if polyout1sum exists and process the in-polygon values
    if exist('polyout1sum', 'var') == 1
        % Precompute polygon vertices for efficiency
        vertices = polyout1sum.Vertices;
        
        % Use vectorized approach to fill in values inside polygon
        [in(:, :)] = deal(TT1);
        in(~inpolygon(xx, yy, vertices(:, 1), vertices(:, 2))) = NaN;
        
        % outputArg1 is the calculated background temperature
        outputArg1 = nanmean(in(:));  % Calculate mean of non-NaN values
        WS = TT1 - outputArg1;
        outputArg2 = WS;
        % outputArg3 = histcounts(WS, [1 2 3 4 100]);
    else
        outputArg1 = nanmean(in(:));  % Calculate mean of non-NaN values
        WS = TT1 - outputArg1;
        outputArg2 = WS;
        % outputArg3 = [0, 0, 0, 0];
    end
end
