LSTMTrainFilename = fopen('C:\Users\suraiya jabin\Documents\MATLAB\StartStopLstmModels13Apr_final\Test1\LSTM_Test1_13apr.txt','w');
fprintf(LSTMTrainFilename,'user_number\taccuracy\tTAR\tFAR\tFRR\tTP\tFN\tFP\tTN\n');
% LOAD RealUserMapFake and LSTMFixLenTrim
%%
base_dir1='C:\Users\suraiya jabin\Documents\MATLAB\StartStopLstmModels13Apr_final';
base_dir2='C:\Users\suraiya jabin\Documents\MATLAB\StartStopLstmModels13Apr_final\Test1';
%Please make the changes in line1,line 5 , line 6
%line1: correspond to the text file saving the evaluation results.
%line 5:base_dir1 correspond to directory in which models are saved while training
%line 6:base_dir2 correspond to directory in which testing results will be saved.
cd(base_dir2);
% day4=[1,4,11,25];
for i=1:32
% c=0;
% i=day4(idx);
load(base_dir1+"\"+int2str(i)+".mat");

XTest=XTest1;
YTest=YTest1;

XTest(end+1:end+size(XTest2,1),1)=XTest2;
YTest(end+1:end+size(XTest2,1),1)=YTest2;

%% TESTING
%
numObservations = numel(XTest);

miniBatchSize =1;
%get the sequence length from each observation

for j=1:numObservations
    sequence = XTest{j};
    sequenceLengths(j) = size(sequence,2);
end

%sort the sequence length and get the index in 'idx' so that the Xtrain and
%YTest can be sorted accordingly

[sequenceLengths,idx] = sort(sequenceLengths);
XTest = XTest(idx);
YTest = YTest(idx);


[YPred,scores] = classify(net,XTest, ...
    'MiniBatchSize',miniBatchSize, ...
    'SequenceLength','longest');


confmat=confusionmat(YTest,YPred)
accuracy = sum(YPred ==YTest )/numel(YTest)
%%
targets=zeros(2,size(YTest,1));
for j=1:size(YTest,1)
    if YTest(j,1)=='1'
        targets(1,j)=1;
    else
        targets(2,j)=1;
    end
 end
outputs=scores';

[tpr,fpr,thresholds]=roc(targets,outputs);

for j=1:2
   for k=1:size(tpr{1,j},2)
       fnr{1,j}(1,k)=1-tpr{1,j}(1,k);
   end
end
%%
TAR=confmat(1,1)/(confmat(1,1)+confmat(1,2));
FAR=confmat(2,1)/(confmat(2,1)+confmat(2,2));
FRR=confmat(1,2)/(confmat(1,2)+confmat(1,1));

save(int2str(i)+".mat",'i','FAR','FRR','TAR','confmat','accuracy','XTrain','XTest','YTrain','YTest','YPred','net','scores','thresholds','tpr','fpr','fnr');


            fprintf(LSTMTrainFilename,'%d',i);
            fprintf(LSTMTrainFilename,'\t');
%             fprintf(LSTMTrainFilename,user_name(i));
%             fprintf(LSTMTrainFilename,'\t');
            fprintf(LSTMTrainFilename,'%f',accuracy);
            fprintf(LSTMTrainFilename,'\t');
            fprintf(LSTMTrainFilename,'%f',TAR);
            fprintf(LSTMTrainFilename,'\t');
            fprintf(LSTMTrainFilename,'%f',FAR);
            fprintf(LSTMTrainFilename,'\t');
            fprintf(LSTMTrainFilename,'%f',FRR);
            fprintf(LSTMTrainFilename,'\t');
            fprintf(LSTMTrainFilename,'%d',confmat(1,1));
             fprintf(LSTMTrainFilename,'\t');
              fprintf(LSTMTrainFilename,'%d',confmat(1,2));
             fprintf(LSTMTrainFilename,'\t');
              fprintf(LSTMTrainFilename,'%d',confmat(2,1));
             fprintf(LSTMTrainFilename,'\t');
              fprintf(LSTMTrainFilename,'%d',confmat(2,2));
            fprintf(LSTMTrainFilename,'\n');

clear accuracy confmat scores XTrainFake XTrainReal XTrain YTrain XTest YTest YPred net tpr fpr fnr FAR FRR  targets thresholdsclear YTest2 YTest XTest2 XTest XTest3 YTest3 sequence sequenceLengths idx targets;
%
i

end