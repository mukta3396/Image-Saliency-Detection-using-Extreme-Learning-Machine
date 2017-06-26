path = path_files();
path_size = size(path,2);
ctr=1;
for itr=1:path_size
    imggnd = double(imread(path{itr}))/255;
    imgsal = sal_imgcellsimpsal{1,itr};
    row = size(imggnd,1);
    col = size(imggnd,2);
    pixels=row*col;
    value = abs(imggnd-imgsal);
    accuracy{itr} = (pixels - sum(sum(value)))/pixels *100; 
end