%% calculate RGB,Lab,lbp for all pixels
function [training] = test(featurevector,rows,cols,numlabels,reshapelabel,itr,Map_cell)
training=zeros(numlabels,7);
training=double(training);
%gray=rgb2gray(img);
sal_map=reshape(Map_cell,rows*cols,1);
%sal_map=reshape(img,rows*cols,1);
avg_sal_score=sum(sal_map)/(rows*cols);
pos_treshold=1.5*avg_sal_score;
neg_treshold=0.05;
featurevector=cat(2,featurevector,sal_map);
for k=0:numlabels-1
    count=0;
    for i=1:size(reshapelabel)
            if(reshapelabel(i)==k)
               training(k+1,:)=training(k+1,:)+double(featurevector(i,:));
               count=count+1;
            end
    end
    training(k+1,:)=training(k+1,:)*(1/count); 
    if(training(k+1,7)>pos_treshold)
    training(k+1,7)=1;
    else
    training(k+1,7)=0;
    end
end
end