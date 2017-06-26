FeatureVectorImage=[];
training_select=[];
%mapping=getmapping(8,'u2');
load('simpsal_big_matrix_25022017.mat');
%load('gbvs_1000_matrix_final_set.mat');
path = path_files();
path_size = size(path,2);
for itr=1:path_size
img = imread(path{itr});
[rows,cols,dim] = size(img);
[labels, numlabels] = slicomex(img,50);%numlabels is the same as number of superpixels
%figure;
%imagesc(labels);
reshapelabel=transpose(reshape(labels,1,prod(size((labels)))));
%% final feature vector
I = rgb2gray(img);
hsvimg=rgb2hsv(img);
hsv=reshape(hsvimg,prod(size(labels)),3);
J = adapthisteq(I);
K = medfilt2(J);
% entropy value of 9*9 neighbourhood of the pixel. Entropy - histogram
% uniformity
L=entropyfilt(K);
reshapeL=transpose(reshape(L,1,prod(size((L)))));
% standard deviation of each pixel with 3*3 window size
M=stdfilt(K);
reshapeM=transpose(reshape(M,1,prod(size((M)))));
featurevector = cat(2,reshapeL,reshapeM);
featurevector = cat(2,featurevector,hsv);
training_data=test_entropy(featurevector,rows,cols,numlabels,reshapelabel,itr,Map_cell_big);
%k=1;
%for i=1:size(training_data,1)
 %  if(training_data(i,6)==1)
  %    training_select(k,:)=training_data(i,:);
   %    k=k+1;
   %end
   %if(training_data(i,6)==0)
    %   training_select(k,:)=training_data(i,:);
     %  k=k+1;
   %end
%end
FeatureVectorCell{itr} = training_select;


%FeatureVectorImage=cat(1,FeatureVectorImage,training_data);
%featurevector=traning_data;
FeatureVectorCell{itr} = training_data;
end
