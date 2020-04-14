
% select the test and train for fake
function [XTrain,YTrain,XTest,YTest]=train_test_split12apr(XTrainReal,XTrainFake)
% 7 samples of from real
s=7;
max=size(XTrainReal,1);
r=randperm(max,s);

%%
XTest=XTrainReal(r);
YTest(1:s)=categorical(1);

XTrainReal(r)=[];
%%
XTrain=XTrainReal;
YTrain(1:size(XTrain,1))=categorical(1);
%%
clear r max;

% 4 samples from Fake to test
s=4;
% select the test and train for fake
max=size(XTrainFake,1);
r=randperm(max,s);
% r=[7 8 9 10];
%%

min=size(XTest,1)+1;
max=size(XTest,1)+s;

XTest(min:max)=XTrainFake(r);
YTest(min:max)=categorical(0);



XTrainFake(r)=[];
% YTrainFake(r)=[]
%%
min=size(XTrain,1)+1;
max=size(XTrain,1)+size(XTrainFake,1);

XTrain(min:max)=XTrainFake;
YTrain(min:max)=categorical(0);

YTrain = removecats(YTrain');
YTest = removecats(YTest');
%%
% clear XTrainFake XTrainReal max min i l r
end