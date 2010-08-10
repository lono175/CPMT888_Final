function Frames = GetFrames(dir, nFrame)

    frame_dir = sprintf('./%s', dir);
    for f_i=1:nFrame
        Frames(:,:,f_i) = rgb2gray(imread(sprintf('%s/%05d.jpg',frame_dir, f_i)));
    end
    %normalize the frame
    %Frames(:, :, :) = Frames(:, :, :);
end
