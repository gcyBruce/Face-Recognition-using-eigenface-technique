k = 10;
d = ones([1,135]); 
trainpath = 'CLab3_materials/yalefaces/trainingset2/';
testpath = 'CLab3_materials/yalefaces/testset2/';   
train_filenames = dir([trainpath '*.png']);    % return a structure with filenames
test_filenames = dir([testpath '*.png']);      % return a structure with filenames
img_num=length(train_filenames);
img_num2=length(test_filenames);

M = zeros([10000,img_num]);
M2 = zeros([10000,img_num]);
%read all train images.
for j = 1:img_num
    filename = [trainpath train_filenames(j).name];   % filename in the list
    I = imread(filename);
    I1 = imresize(I,[100 100]);% resize it to 100x100
    I1 = double(I1);
    M(:,j) = reshape(I1,10000,1);   %represent each image as a column, and make up a data matrix.
end
MT=M';      %transpose matrix M.
M_average = mean(MT); %get the average face.
averageface = reshape(M_average,100,100);  %reshape the average face from a high dimensional vector to a matrix.
A = uint8(averageface);
figure, imshow(A); title('average_face');  %display the average face.
%minus average face for each face.
for i = 1:img_num 
    M2(:,i) = M(:,i) - M_average';
end
%perform PCA on the data matrix.
C = M2'*M2*(1/img_num); %get inner-product matrix to calculate the eigenvalues.
 [V,D] = eigs(C,k); %calculate the the k eigenvectors V with largest eigenvalues D.
%get k eigenfaces.
 eigenface = zeros(10000,k);
 for i=1:k
     eigenface(:,i)= M2*V(:,i); %calculate the eigenfaces and save in one matrix.
 end
 %show the eigenfaces.
 figure;  
for i = 1:k  
    image = eigenface(:,i);  %get each eigenface's high dimensional vector. 
    image = reshape(image,100,100);  %reshape the vector to a image.
    subplot(2,5,i);  %show the eigenfaces in one image.
    imshow(image);title(['eigenface',num2str(i)]);  
end  
 %using linear combinations of eigenfaces to represent all the training images
 M3 = zeros(img_num,k);
for i = 1:img_num  
    M3(i,:) = M2(:,i)' * eigenface ;   %calculate the mapping matrix and save it.
end  

%read the test images.
for n = 1:img_num2
    filename2 = [testpath test_filenames(n).name]; 
    t = imread(filename2);
    t1 = imresize(t,[100 100]); % resize it to 100x100
    t1 =  double(t1);
    t2 = reshape(t1,10000,1); %translate the test image to a high dimensionak vector.
    t3 = t2 - M_average'; %minus the averge face for each test face.
    feature_vec = t3' * eigenface ; %calculate the similarity of the input to each training image
    %using Euclidean distance to calculate the distance between test image
    %and each training image. 
    for j = 1:img_num
         gap = feature_vec - M3(j,:);
         d(1,j)= sqrt(sum(gap.^2));
    end
    %compare the distances and find the three minimum values.
    [val,indx] = sort(d); %range the distances.
    min_distance = indx(1); %find the minimum distance image number.
    sec_distance = indx(2); %find the second smallest distance image number.
    thi_distance = indx(3); %find the third smallest distance image number.
    %get the original images for the test image and similar training
    %images.
    image_test = imread([testpath test_filenames(n).name]);
    image_1 = imread([trainpath train_filenames(min_distance).name]);
    image_2 = imread([trainpath train_filenames(sec_distance).name]);
    image_3 = imread([trainpath train_filenames(thi_distance).name]);
    %show the four images. 
    figure 
    subplot(1,4,1); imshow(image_test); title(test_filenames(n).name); xlabel('k=10');
    subplot(1,4,2); imshow(image_1); title('Recognition image1'); 
    subplot(1,4,3); imshow(image_2); title('Recognition image2'); 
    subplot(1,4,4); imshow(image_3); title('Recognition image3'); 
end

