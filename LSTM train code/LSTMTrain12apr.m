% XTrain=data12;
% YTrain=data12Label;
function [net,options,layers]=LSTMTrain12apr(XTrain,YTrain)


numObservations = numel(XTrain);

%get the sequence length from each observation

for i=1:numObservations
    sequence = XTrain{i};
    sequenceLengths(i) = size(sequence,2);
end

%sort the sequence length and get the index in 'idx' so that the Xtrain and
%YTrain can be sorted accordingly
[sequenceLengths,idx] = sort(sequenceLengths);
XTrain = XTrain(idx);
YTrain = YTrain(idx);


miniBatchSize = 4;
inputSize = 16;
numHiddenUnits = 273;
numClasses = 2;

layers = [ ...
    sequenceInputLayer(inputSize)
    bilstmLayer(numHiddenUnits,'OutputMode','last')
    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer
    ];


maxEpochs = 150;
% miniBatchSize = 27;

options = trainingOptions('rmsprop', ...
    'ExecutionEnvironment','gpu', ...
    'GradientThreshold',1, ...
    'MaxEpochs',maxEpochs, ...
    'MiniBatchSize',miniBatchSize, ...
    'LearnRateDropFactor',0.2,...
    'SequenceLength','longest', ...
    'Shuffle','every-epoch',...
    'Verbose',0);%...
%      'Plots','training-progress');
 
 
%%
net = trainNetwork(XTrain,YTrain,layers,options);
end