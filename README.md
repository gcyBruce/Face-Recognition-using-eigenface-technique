# Face-Recognition-using-eigenface-technique

1.you are given a "training_set" dataset of totally 135 face images captured from 15 individuals (i.e. available in "Yale- FaceA.zip"). Each individual has 9 images in the "training" dataset. You are also given 10 test images in the "Test_set" directory.
(1) Open the training images, and have a look at them, and get an idea about what the images look like.
(2) Please use all the 135 images to train Eigen-faces.

Specifically, at a minimum your face recognition system should do the following:

2. Read all the 135 face images, represent each of the images as a single high dimensional vector, and collect all the vectors into a big data matrix.

3. Perform PCA on the data matrix.

4. Determine the top k principal components, display the top-k
eigenfaces on your screen (and also include them in your Lab Report with proper caption). Try both k=5 and k=10 cases.

5. For each of the 10 test images, read in the image, determine its projection onto the basis spanned by the top k eigenfaces. Use this projection, do a nearest-neighbour search over all the 135 faces, find out which three images are the most similar faces. Display these top 3 faces next to the input test image on screen (and in your Lab report). What is the recognition rate of your method?

Hints for doing PCA-Eigen Face computation:
(1) Before doing anything, you must make sure that all face images must be geometrically aligned. Specifically, you need to take into account of the differences in position of the face in each image. A simple way is, before you do any training or testing, you should manually crop the face region out, define a standard window size, resize the face image, make sure the face region are all aligned -- e.g. eyes, noses, mouths are roughly at the same positions in an image --save the results into disk, so you don't have to do the above pre-processing more than once.
(2) In doing eigen-decomposition, always remember to subtract the mean face and, when reconstructing images based on the first k principal components, add the mean face back in at the end.
(3) You can Matlab's eigs() functions to implement PCA. Other than this, you should not use Matlab's inbuilt eigen-face function if there is one. If you encounter some difficulty in solving the eigenvalues/eigenvectors for inner-product matrix (A*A' ), think about whether or not you can instead solve the eigen problem for matrix (A’*A). Explain ( in your Lab Report) why this is possible ?
