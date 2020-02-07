imagepath = 'CLab3_materials/yalefaces/testset/'; %the path for getting the orginal faces.
savepath = 'CLab3_materials/yalefaces/testset2/'; %the path for saving cropping faces.
Files = dir([imagepath '*.png']); %open the orginal  face file.
for j=1:length(Files) %figure show all the face image.
        I=imread(strcat(imagepath,Files(j).name));  
    imshow(I);  
    [x,y] = ginput(2);  %using ginput() function to get the cropping face's starting and ending coordinates.
    if x(1)==x(2) && y(1)==y(2)  %if double-click image, skip this image.
        continue;  
    end  
    rect=[x(1),y(1),x(2)-x(1),y(2)-y(1)];  %get the new face image's coordinates and size.
    J=imcrop(I,rect);  %crop the new face.
    name=strcat(num2str(Files(j).name));  %give the same name for the new face image.
    imwrite(J,strcat(savepath,name));   %save the image in the savepath file.
end  