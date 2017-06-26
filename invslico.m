path = path_files();
path_size = size(path,2);
ctr=1;
for itr=1:path_size
img = imread(path{itr});
sal_img=zeros(size(img,1),size(img,2));
sal_img1=zeros(size(img,1),size(img,2));
scale=50;
[labels, numlabels] = slicomex(img,scale);
    for i=1:size(labels,1)
        for j=1:size(labels,2)
            sal_img(i,j)=sal_img(i,j)+texture_color_gbvs(labels(i,j)+ctr);
           % sal_img1(i,j)=sal_img1(i,j)+gbvs(labels(i,j)+ctr);
        end
    end
sal_imgcell{itr}=sal_img;
%sal_imgcellgbvs{itr}=sal_img1;
ctr=ctr+numlabels;
end
