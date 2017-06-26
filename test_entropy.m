%% calculate RGB,Lab,lbp for all pixels

function [training] = test(featurevector,rows,cols,numlabels,reshapelabel,itr,Map_Cell)
training=zeros(numlabels,6);
training=double(training);
%load('gbvs.mat');
sal_map=reshape(Map_Cell{1,itr},rows*cols,1);
avg_sal_score=sum(sal_map)/(rows*cols);
pos_treshold=1.5*avg_sal_score;
neg_treshold=0.05;
featurevector=cat(2,featurevector,sal_map);
for k=0:numlabels-1
    count=0;
    for i=1:size(reshapelabel)
            if(reshapelabel(i)==k)
               training(k+1,:)=training(k+1,:)+featurevector(i,:);
               count=count+1;
            end
    end
    training(k+1,:)=training(k+1,:)*(1/count); 
    if(training(k+1,6)>pos_treshold)
    training(k+1,6)=1;
    else
        %if (training(k+1,6)<neg_treshold)
        training(k+1,6)=0;
        %end
    end
end
end
