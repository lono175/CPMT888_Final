%load classification_mask
%wave1G = GetPatch(original_masks, 'denis_wave1');
%bendG = GetPatch(original_masks, 'denis_bend');

%%Get part of wave1G to extract the key patches
%partWave1G = wave1G(:, :, 1:4, :, :);

%kernelG = partWave1G;
%patchG = bendG;

%negMat = Kernelize(kernelG, patchG);

%%construct positive set
%posMat = Kernelize(kernelG, kernelG);


Nfolds = 2;


Xtrain = [posMat; negMat; posMat];
ytrain = [ones(size(posMat, 1), 1); zeros(size(negMat, 1), 1); ones(size(posMat, 1), 1)];
Xtest = Xtrain;
ytest = ytrain;

%Xtrain = Xtrain(1:50, :);
%ytrain = ytrain(1:50);
Ntest = length(ytest);
method={'svmRbf','svmLinear','Log'};

for i=3
    switch method{i};
        case 'svmRbf'
            fitFn=@(X,y)svmFit(X,y,'fitFn','svmlibFit','kernel','Rbf');
            predictFn=@(model,X)svmPredict(model,X);

        case 'svmLinear'
            fitFn=@(X,y)svmFit(X,y,'fitFn','svmlibFit','kernel','linear');
            predictFn=@(model,X)svmPredict(model,X);

        case 'Log'
            %params = linspace(1, 10, 10);
            params = [1];
            fitFn = @(X,y)logregFit(X, y,'lambda', params, 'regType','L1');
            predictFn = @(model,X)logregPredict(model, X);
        end
       
        lossFn = @(y, yhat) length(find(y ~= yhat)); 
        [mu(i) se(i)]=cvEstimate(fitFn, predictFn, lossFn, Xtrain, ytrain,  Nfolds);
        
        CvError(i)=mu(i);
        model=fitFn(Xtrain,ytrain);
        yhat=predictFn(model,Xtest);
        testError(i) = length(find(yhat ~= ytest))/Ntest;
        %testError(i,k)=length(find(yhat ~= ytest))/Ntest; 
end



% get a training data
% Frames is sequence of frames, N-by-M-by-T

%try to jitter the data(reflection, slightly shift)

%bSize = [2, 2, 1]; %half block size to compute the derivative
%pSize = [2, 2, 2]; %half ST patch size 
%clipSize = [80,40];

%get the foreground image
%load classification_masks
%%mask = original_masks.denis_wave1;
%mask = original_masks.denis_bend;
%frame_dir = 'denis_bend';

%nFrame = size(mask, 3);
%Frames = LoadFrames(frame_dir, nFrame);
%scaleFrames = GetScaleFrames(Frames, mask, clipSize);

%%compute 3D derivative
%pDerivative = GetDerivative(scaleFrames, bSize);

%%compute G matrix for each ST patches
%patchG = GetG(pDerivative, pSize);

%frame_dir = 'D:\CPMT888\CPMT888_Final\wave1\wave1'
%nFrame = size(mask, 3)
%index = 1
%type = 'wave1'


%box = [];
%for f_i=1:nFrame
%tmp = regionprops(mask(:, :, f_i), 'boundingbox')
%center = regionprops(mask(:, :, f_i), 'centroid');
%box(f_i, :) = [tmp.BoundingBox round(center.Centroid)];
%end

%diffX = [box(:, 3) - box(:, 5) + box(:, 1); box(:, 1) - box(:, 5)];
%diffY = [box(:, 4) - box(:, 6) + box(:, 2); box(:, 2) - box(:, 6)];
%maxHalfWidth = max(abs(diffX));
%maxHalfHeight = max(abs(diffY));

%Frames = [];
%clipFrames = [];
%for f_i=1:nFrame
%Frames(:,:,f_i) = rgb2gray(imread(sprintf('%s/%s%05d.png',frame_dir,type, f_i)));
%%normalize the frame
%Frames(:, :, :) = Frames(:, :, :) ./ 255;

%%Frames(:,:,f_i) = (imread(sprintf('%s/%s%05d.png',frame_dir,type, f_i)));
%%center = regionprops(mask(:, :, f_i), 'centroid');
%%center = center.Centroid;
%startX = round(box(f_i, 5) - maxHalfWidth);
%endX = round(box(f_i, 5) + maxHalfWidth);
%startY = round(box(f_i, 6) - maxHalfHeight);
%endY = round(box(f_i, 6) + maxHalfHeight);
%clipFrames(:, :, f_i) = Frames(startY:endY, startX:endX, f_i);
%end

%%sacle it to 80X40
%for f_i=1:nFrame
%scaleFrames(:, :, f_i) = imresize(clipFrames(:, :, f_i), clipSize);
%end



%imheight = size(scaleFrames, 1)
%imwidth = size(scaleFrames, 2)
%pDerivative = [];
%for y = 1 + bSize(1): imheight - bSize(1)
%for x = 1 + bSize(2): imwidth - bSize(2)
%for t = 1 + bSize(3): nFrame - bSize(3)
%block = scaleFrames(y-bSize(1):y+bSize(1), x-bSize(2):x+bSize(2), t-bSize(3):t+bSize(3));
%[Ix,Iy,It] = partial_derivative_3D(block);
%pDerivative(y-bSize(1), x-bSize(2), t-bSize(3), :) = [Ix, Iy, It];
%end
%end
%end


%imheight = size(pDerivative, 1)
%imwidth = size(pDerivative, 2)
%nFrame = size(pDerivative, 3)
%scale = 1
%patchG = [];
%i = 0;
%for y = 1 + pSize(1): pSize(1)/scale: imheight - pSize(1)
%i = i + 1;
%j = 0;
%for x = 1 + pSize(2): pSize(2)/scale: imwidth - pSize(2)
%j = j + 1;
%k = 0;
%for t = 1 + pSize(3): pSize(3)/scale: nFrame - pSize(3)
%%[y x t]
%k = k + 1;
%G = [];
%block = pDerivative(y-pSize(1):y+pSize(1), x-pSize(2):x+pSize(2), t-pSize(3):t+pSize(3), :);
%G = reshape(block, numel(block)/3,3);
%patchG(i, j, k, :, :) = G;
%end
%end
%end



%test against corr

%[VX,VY]=lk3(Frames);

%% Visualize (unblurred) flow.
%if 1
%im_i=2; % Note, no flow for first and last images.
%figure(1);
%imshow(Frames(:,:,im_i))
%hold on;
%quiver(VX(:,:,im_i-1),VY(:,:,im_i-1),0);
%hold off
%end

%opticalFlow{index} = {type, Frames};
%opticalFlow2{index} = {type, VX, VY};
% use gentle boost, find key point
% get a test data
