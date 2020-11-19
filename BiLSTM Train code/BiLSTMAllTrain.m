% directory where the models save and it needs to be changed so that the
% next time model train do not override the existing model in the folder 
 load('G:\sumaiya work apr 2018\GRU_code_Statis feat 5 sep 2020\Live_Sign_stat.mat')
 base_dir='G:\sumaiya work apr 2018\GRU_code_Statis feat 5 sep 2020\Liveness authentication';
%addpath('G:\sumaiya work apr 2018\GRU_code_Statis feat 5 sep 2020')
%load('G:\sumaiya work apr 2018\GRU_code_Statis feat 5 sep 2020\Mid_Sign_stat.mat')
%base_dir='G:\sumaiya work apr 2018\GRU_code_Statis feat 5 sep 2020\Sign authentication';
cd(base_dir);

% for i=1:32
user_i=[23]
for ui=1:size(user_i,2) 
%     get each user id in i

    XTempFake={}; 
    XTest3={};   
    XTest4={};
    i=user_i(ui);
    
    
    l=dataLabelReal==categorical(i);  
    XTrainReal=dataReal(l);
    
    l=dataLabelFake==categorical(i);
    XTrainFake=dataFake(l);
    
    for indx=1:32
    if indx==i 
        continue
    else
        l=dataLabelReal==categorical(indx);
        k=find(l);
%%Random Fake Training
        XTempFake(end+1,1)=dataReal(k(1,1));
%%Random Fake Test  
        XTest3(end+1,1)=dataReal(k(2,1));
%%Random Fake Anti-Spoof Test        
        XTest4(end+1,1)=dataReal(k(3,1));
    end
    end
%     
%% call the function to select the sensor data 
%     s=0  %Acceleration
%     s=4  % Angular Velocity
%     s=8  %Magnetic Field
%     s=12 %Orientation
%     
%     l=dataLabelReal==categorical(i); 
%     XTrainReal=getSensorSpecific(dataReal(l),s);
%  
%     l=dataLabelFake==categorical(i);
%     XTrainFake=getSensorSpecific(dataFake(l),s);

 %% random forgery  

%     for indx=1:32
%     if indx==i 
%         continue
%     else
%         l=dataLabelReal==categorical(indx);
%         k=find(l);
%         
%         XTempFake(end+1,1)=getSensorSpecific(dataReal(k(1,1)),s);
% 
%         XTest3(end+1,1)=getSensorSpecific(dataReal(k(2,1)),s);
% 
%     end
%     end

%%

    [XTrain,YTrain,XTest,YTest]=train_test_split(XTrainReal,XTrainFake);
    
    
%%


XTrain(end+1:end+size(XTempFake,1),1)=XTempFake;
YTrain(end+1:end+size(XTempFake,1),1)=categorical(0);


l=YTest==categorical(1);
XTest1(1:size(XTest(l),1),1)=XTest(l);
YTest1(1:size(XTest(l),1),1)=categorical(1);

l=YTest==categorical(0);
XTest2(1:size(XTest(l),1),1)=XTest(l);
YTest2(1:size(XTest(l),1),1)=categorical(0);

YTest3(1:size(XTest3,1),1)=categorical(0);

YTest4(1:size(XTest4,1),1)=categorical(0);



%%


[net,options,layers]=LSTMTrain(XTrain,YTrain)
%% TESTING
% SEPARATE SCRIPTS

           
save(int2str(i)+".mat",'i','XTrain','XTest1','XTest2','XTest3','YTrain','YTest1','YTest2','YTest3','XTest4','YTest4','net','options','layers' );

%%
% % Test1
% miniBatchSize=1
% [YPred1,scores] = classify(net,XTest1, ...
%     'MiniBatchSize',miniBatchSize, ...
%     'SequenceLength','longest');
% confmat1=confusionmat(YTest1,YPred1)
% accuracy1 = sum(YPred1 ==YTest1 )/numel(YTest1)
% 
% % Test2
% 
% [YPred2,scores] = classify(net,XTest2, ...
%     'MiniBatchSize',miniBatchSize, ...
%     'SequenceLength','longest');
% confmat2=confusionmat(YTest2,YPred2)
% accuracy2 = sum(YPred2 ==YTest2 )/numel(YTest2)
% 
% %Test 3
% 
% [YPred3,scores] = classify(net,XTest3, ...
%     'MiniBatchSize',miniBatchSize, ...
%     'SequenceLength','longest');
% confmat3=confusionmat(YTest3,YPred3)
% accuracy3 = sum(YPred3 ==YTest3 )/numel(YTest3)
% 


%%
clear  XTrainFake XTrainReal XTempFake  XTrainFake   XTrain YTrain XTest1 YTest1 XTest2 YTest2 XTest3 YTest3 net 
%%
i
end
