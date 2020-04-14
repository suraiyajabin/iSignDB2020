
LSTMTrainFilename = fopen('C:\Users\suraiya jabin\Documents\MATLAB\LSTMStartStop9Apr\TestResults12apr\Test2\LSTM_StartStopEERTest2_11apr','w');
fprintf(LSTMTrainFilename,'user_number\tEER\n');
base_dir='C:\Users\suraiya jabin\Documents\MATLAB\LSTMStartStop9Apr\TestResults12apr\Test2';
cd(base_dir);
for i=1:32

load(base_dir+"\"+int2str(i)+".mat");
   

[xi,yi] = polyxpoly(thresholds{1,1},fpr{1,1},thresholds{1,1},fnr{1,1},'unique')
EER=double(yi)

%figure
%plot(thresholds{1,1},fpr{1,1},'LineWidth',1.5)
%hold on
%plot(thresholds{1,1},fnr{1,1},'LineWidth',1.5)
%xlabel('Threshold')
%ylabel('Error')
%legend('FAR','FRR')
%axis([-0.2 1.5 -0.2 1.5])
%plot(xi,yi,'o','MarkerSize',13)
%text(double(xi)-0.1,double(yi)+0.1,"EER="+yi+' at '+xi)
%hold off

 
 
            fprintf(LSTMTrainFilename,'%d',i);
            fprintf(LSTMTrainFilename,'\t');
            fprintf(LSTMTrainFilename,'%f\n',EER);
save
clear xi yi EER accuracy confmat scores XTrainFake XTrainReal XTrain YTrain XTest YTest YPred net tpr fpr fnr FAR FRR  targets thresholds
%
i
end
fclose(LSTMTrainFilename);