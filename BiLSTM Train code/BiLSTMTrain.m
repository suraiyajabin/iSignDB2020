% XTrain=data12;
% YTrain=data12Label;
function [net,options,layers]=LSTMTrain(XTrain,YTrain)


numObservations = numel(XTrain);

%get the sequence length from each observation

for i=1:numObservations
    sequence = XTrain{i};
    sequenceLengths(i) = size(sequence,2);
end

%sort the sequence length and get the index in 'idx' so that the Xtrain and
%YTrain can be sorted accordingly
[sequenceLengths,idx] = sort(sequenceLengths);
%XTrain = XTrain(idx);
%YTrain = YTrain(idx);

idx = randperm(numObservations);
N = floor(0.9 * numObservations);

idxTrain = idx(1:N);
XTrainseq = XTrain(idxTrain);
YTrainseq = YTrain(idxTrain);

idxValidation = idx(N+1:end);
XVal = XTrain(idxValidation);
YVal = YTrain(idxValidation);


miniBatchSize = 1;
inputSize = 112;
numHiddenUnits = 64;
numClasses = 2;

layers = [ ...
    sequenceInputLayer(inputSize)
%     gruLayer(600,'OutputMode','last')

    bilstmLayer(90,'OutputMode','last')
    bilstmLayer(numHiddenUnits,'OutputMode','last')
    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer
    ];


maxEpochs = 900;
% miniBatchSize = 27;

options = trainingOptions('adam', ...
    'ExecutionEnvironment','gpu', ...
    'GradientThreshold',1.5, ...
    'MaxEpochs',maxEpochs, ...
    'MiniBatchSize',miniBatchSize, ...
    'LearnRateDropFactor',0.1,...
    'ValidationData',{XVal,YVal},...
    'ValidationPatience',25,...
    'Shuffle','every-epoch',...
    'LearnRateSchedule','piecewise',...
    'SequenceLength','longest', ...
    'Verbose',0,...
     'Plots','training-progress');
 
 
%%
net = trainNetwork(XTrainseq,YTrainseq,layers,options);
end