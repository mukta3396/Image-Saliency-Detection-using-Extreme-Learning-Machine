mapping=getmapping(8,'u2');
training_select=[];
featurevector_final=[];
%load('gbvs_1000_matrix_final_set.mat');
load('simpsal_big_matrix_25022017.mat');
path = path_files();
path_size = size(path,2);
for itr=1:path_size
img = imread(path{itr});
[rows,cols,dim] = size(img);
FeatureVectorImage=[];
scale=50;
[labels, numlabels] = slicomex(img,scale);%numlabels is the same as number of superpixels
%figure;
%imagesc(labels);
reshapelabel=transpose(reshape(labels,1,prod(size((labels)))));
rgb=reshape(img,prod(size(labels)),3);
colorTransform = makecform('srgb2lab');
lab_image = applycform(img, colorTransform);
lab=reshape(lab_image,prod(size(labels)),3);
rgb=double(rgb);
featurevector=cat(2,rgb,lab);
featurevector=double(featurevector);
segmented_img=cell(1,numlabels);
seg_label=repmat(labels,[1 1 3]);
black = zeros(1,numlabels);
for l=0:numlabels-1
    color = img;
    color(seg_label~=l) =0;
    segmented_img{l+1} = color;
end
%% counting pixel frequency
nonblack = zeros(1,numlabels);
for i=0:numlabels-1
    for j=2:rows-1
        for k=2:cols-1
            if(i==labels(j,k))
                nonblack(1,i+1)=nonblack(1,i+1)+1;
            end
        end
    end
end

%% final histogram for every super pixel
black= zeros(1,numlabels);
black(:,:)=(rows-2)*(cols-2);
black_final=black-nonblack;
hist = [];
for i=0:numlabels-1
        seg_gray=rgb2gray(segmented_img{i+1});
    temp_hist=lbp(seg_gray,1,8,mapping,'h');
    temp_hist(1,58)=temp_hist(1,58)-(black_final(1,i+1));
    hist=cat(1,hist,temp_hist);
end
%% final feature vector
%training_data=test(featurevector,rows,cols,numlabels,reshapelabel,itr,Map_cell_big);
training_data=test1(featurevector,rows,cols,numlabels,reshapelabel,itr,Map_cell_big);
training_final = cat(2,training_data,hist);
k=1;
for i=1:size(training_final,1)
   if(training_final(i,7)==1)
      training_select(k,:)=training_final(i,:);
       k=k+1;
   end
   if(training_final(i,7)==0)
       training_select(k,:)=training_final(i,:);
       k=k+1;
   end
end
FeatureVectorCell{itr} = training_select;
%FeatureVectorCell{itr}=training_final;
end