
LSTMTrainFilename = fopen('C:\Users\suraiya jabin\Documents\MATLAB\LSTMSignModel_14apr\LSTM_SS14Apr.txt','w');
%fprintf(LSTMTrainFilename,'user_number\taccuracy\tTAR\tFAR\tFRR\tconfusion matrix comma separated values\n');
fprintf(LSTMTrainFilename,'user_number\taccuracy1\tTAR1\tFAR1\tFRR1\tTP1\tFN1\tFP1\tTN1\t\taccuracy2\tTAR2\tFAR2\tFRR2\tTP2\tFN2\tFP2\tTN2\t\taccuracy3\tTAR3\tFAR3\tFRR3\tTP3\tFN3\tFP3\tTN3\n');

%%
base_dir='C:\Users\suraiya jabin\Documents\MATLAB\LSTMSignModel_14apr';
cd(base_dir);

%for i=32:32
u=[30];%specify the user number to train, example here user 8,15,27 will be trained
for u_index=1:size(u,2)
    i=u(u_index);

    
    %%

    l=dataLabelReal==categorical(i);
    XTrainReal=dataReal(l);
    
     l=dataLabelFake==categorical(i);
    XTrainFake=dataFake(l);
    %%
     XTempFake={};
    XTest3={};

    for indx=1:32
    if indx==i 
        continue
    else
        l=dataLabelReal==categorical(indx);
        k=find(l);

        XTempFake(end+1,1)=dataReal(k(1,1));

        XTest3(end+1,1)=dataReal(k(2,1));

    end
    end
    
    
%%
[XTrain,YTrain,XTest,YTest]=train_test_split9apr(XTrainReal,XTrainFake);

XTrain(end+1:end+size(XTempFake,1),1)=XTempFake;
YTrain(end+1:end+size(XTempFake,1),1)=categorical(0);


l=YTest==categorical(1);
XTest1(1:size(XTest(l),1),1)=XTest(l);
YTest1(1:size(XTest(l),1),1)=categorical(1);

l=YTest==categorical(0);
XTest2(1:size(XTest(l),1),1)=XTest(l);
YTest2(1:size(XTest(l),1),1)=categorical(0);

YTest3(1:size(XTest3,1),1)=categorical(0);
%%
% net=LSTMTrainOneSingleUser(XTrain,YTrain);

[net,options,layers]=LSTMTrain12apr(XTrain,YTrain)
%% TESTING
%
numObservations = numel(XTest1);

miniBatchSize =1;
%get the sequence length from each observation

for j=1:numObservations
    sequence = XTest1{j};
    sequenceLengths(j) = size(sequence,2);
end

%sort the sequence length and get the index in 'idx' so that the Xtrain and
%YTest can be sorted accordingly

[sequenceLengths,idx] = sort(sequenceLengths);

XTest1 = XTest1(idx);
YTest1 = YTest1(idx);


[YPred1,scores1] = classify(net,XTest1, ...
    'MiniBatchSize',miniBatchSize, ...
    'SequenceLength','longest');


confmat1=confusionmat(YTest1,YPred1)
accuracy1 = sum(YPred1 ==YTest1 )/numel(YTest1)


TAR1=confmat1(1,1)/(confmat1(1,1)+confmat1(1,2));
FAR1=confmat1(2,1)/(confmat1(2,1)+confmat1(2,2));
FRR1=confmat1(1,2)/(confmat1(1,2)+confmat1(1,1));
%%
targets=zeros(2,size(YTest1,1));
for j=1:size(YTest1,1)
    if YTest1(j,1)=='1'
        targets(1,j)=1;         %first row real
    else
        targets(2,j)=1;         %second row fake    
    end
 end
outputs=scores1';

[tpr1,fpr1,thresholds1]=roc(targets,outputs);

for j=1:2
   for k=1:size(tpr1{1,j},2)
       fnr1{1,j}(1,k)=1-tpr1{1,j}(1,k);
   end
end

clear sequence sequenceLengths idx targets outputs
%% TESTING 2
numObservations = numel(XTest2);

miniBatchSize =1;
%get the sequence length from each observation

for j=1:numObservations
    sequence = XTest2{j};
    sequenceLengths(j) = size(sequence,2);
end

%sort the sequence length and get the index in 'idx' so that the Xtrain and
%YTest can be sorted accordingly

[sequenceLengths,idx] = sort(sequenceLengths);

XTest2 = XTest2(idx);
YTest2 = YTest2(idx);


[YPred2,scores2] = classify(net,XTest2, ...
    'MiniBatchSize',miniBatchSize, ...
    'SequenceLength','longest');


confmat2=confusionmat(YTest2,YPred2)
accuracy2 = sum(YPred2 ==YTest2 )/numel(YTest2)


TAR2=confmat2(1,1)/(confmat2(1,1)+confmat2(1,2));
FAR2=confmat2(2,1)/(confmat2(2,1)+confmat2(2,2));
FRR2=confmat2(1,2)/(confmat2(1,2)+confmat2(1,1));

%%
targets=zeros(2,size(YTest2,1));
for j=1:size(YTest2,1)
    if YTest2(j,1)=='1'
        targets(1,j)=1;         %first row real
    else
        targets(2,j)=1;         %second row fake    
    end
 end
outputs=scores2';

[tpr2,fpr2,thresholds2]=roc(targets,outputs);

for j=1:2
   for k=1:size(tpr2{1,j},2)
       fnr2{1,j}(1,k)=1-tpr2{1,j}(1,k);
   end
end

clear sequence sequenceLengths idx targets outputs;
%% TESTING 3
numObservations = numel(XTest3);

miniBatchSize =1;
%get the sequence length from each observation

for j=1:numObservations
    sequence = XTest3{j};
    sequenceLengths(j) = size(sequence,2);
end

%sort the sequence length and get the index in 'idx' so that the Xtrain and
%YTest can be sorted accordingly

[sequenceLengths,idx] = sort(sequenceLengths);

XTest3 = XTest3(idx);
YTest3 = YTest3(idx);


[YPred3,scores3] = classify(net,XTest3, ...
    'MiniBatchSize',miniBatchSize, ...
    'SequenceLength','longest');


confmat3=confusionmat(YTest3,YPred3)
accuracy3 = sum(YPred3 ==YTest3 )/numel(YTest3)


TAR3=confmat3(1,1)/(confmat3(1,1)+confmat3(1,2));
FAR3=confmat3(2,1)/(confmat3(2,1)+confmat3(2,2));
FRR3=confmat3(1,2)/(confmat3(1,2)+confmat3(1,1));
%%


%%
targets=zeros(2,size(YTest3,1));
for j=1:size(YTest3,1)
    if YTest3(j,1)=='1'
        targets(1,j)=1;         %first row real
    else
        targets(2,j)=1;         %second row fake    
    end
 end
outputs=scores3';

[tpr3,fpr3,thresholds3]=roc(targets,outputs);

for j=1:2
   for k=1:size(tpr3{1,j},2)
       fnr3{1,j}(1,k)=1-tpr3{1,j}(1,k);
   end
end

 
 
            fprintf(LSTMTrainFilename,'%d\t',i);
            fprintf(LSTMTrainFilename,'%f\t',accuracy1);
            fprintf(LSTMTrainFilename,'%f\t',TAR1);
            fprintf(LSTMTrainFilename,'%f\t',FAR1);  
            fprintf(LSTMTrainFilename,'%f\t',FRR1);
            fprintf(LSTMTrainFilename,'%d\t',confmat1(1,1));
              fprintf(LSTMTrainFilename,'%d\t',confmat1(1,2));
              fprintf(LSTMTrainFilename,'%d\t',confmat1(2,1));
              fprintf(LSTMTrainFilename,'%d\t\t',confmat1(2,2));
   
            

            fprintf(LSTMTrainFilename,'%f\t',accuracy2);
            fprintf(LSTMTrainFilename,'%f\t',TAR2);
            fprintf(LSTMTrainFilename,'%f\t',FAR2);  
            fprintf(LSTMTrainFilename,'%f\t',FRR2);
            fprintf(LSTMTrainFilename,'%d\t',confmat2(1,1));
              fprintf(LSTMTrainFilename,'%d\t',confmat2(1,2));
              fprintf(LSTMTrainFilename,'%d\t',confmat2(2,1));
              fprintf(LSTMTrainFilename,'%d\t\t',confmat2(2,2));
       
            fprintf(LSTMTrainFilename,'%f\t',accuracy3);
            fprintf(LSTMTrainFilename,'%f\t',TAR3);
            fprintf(LSTMTrainFilename,'%f\t',FAR3);  
            fprintf(LSTMTrainFilename,'%f\t',FRR3);
            fprintf(LSTMTrainFilename,'%d\t',confmat3(1,1));
              fprintf(LSTMTrainFilename,'%d\t',confmat3(1,2));
              fprintf(LSTMTrainFilename,'%d\t',confmat3(2,1));
              fprintf(LSTMTrainFilename,'%d\t\t',confmat3(2,2));
            fprintf(LSTMTrainFilename,'\n');
            
save(int2str(i)+".mat",'i','FAR1','FRR1','TAR1','confmat1','accuracy1','FAR2','FRR2','TAR2','confmat2','accuracy2','FAR3','FRR3','TAR3','confmat3','accuracy3','XTrain','XTest1','XTest2','XTest3','YTrain','YTest1','YTest2','YTest3','YPred1','YPred2','YPred3','net','scores1','thresholds1','tpr1','fpr1','fnr1','scores2','thresholds2','tpr2','fpr2','fnr2','scores3','thresholds3','tpr3','fpr3','fnr3');
%%
clear accuracy1 confmat1 scores1 accuracy2 confmat2 score2 saccuracy3 confmat3 scores3 XTrainFake XTrainReal XTempFake YTempFake XTrainFake YTrainFake XTestFake YTestFake XTrain YTrain XTest1 YTest1 XTest2 YTest2 XTest3 YTest3 YPred net tpr fpr fnr FAR FRR  targets thresholds  sequence sequenceLengths idx targets outputs
%%
i
end
fclose(LSTMTrainFilename);