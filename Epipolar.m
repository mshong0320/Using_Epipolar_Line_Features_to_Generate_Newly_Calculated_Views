function Epi = Epipolar(img,R,T,x,y)
%EPIPOLAR Summary of this function goes here
%   This function calculates the corresponding epipolar line of a given
%   image and a given relative position

%   Input: img is the image to calculate epipolar line for a given point.R
%   and T represent the relative position to the image calculated and x,y
%   is the coordinate of the given point.

%   Output: A n x 2 matrix where n is the number of points on the epipolar
%   line. The columns represent x and y coordinates.

% imageDir_cal= '/Users/mshong0320/Desktop/CV_Project_Data/Calibration1_data';
% images_cal = imageSet(fullfile(imageDir_cal));
% imageFileNames = images_cal.ImageLocation;
% CameraCalib(imageFileNames);
% 
% %%
% CameraParams = ans;
imageDir = '/Users/mshong0320/Desktop/CV_Project_Data/From_Spot3';
images = imageDatastore(imageDir);
fileFolder = fullfile(imageDir);
dirOutput = dir(fullfile(fileFolder,'thumb_IMG_*.jpg'));
fileNames = {dirOutput.name}'
%%
I1 = readimage(images,1);
I2 = readimage(images,2);
cameraParams = calibrationSession.CameraParameters;
montage(fileNames, 'Size', [2 3])

%%
I1gray = rgb2gray(I1);
I2gray = rgb2gray(I2);

% imshow(I1gray);
E = Essential(I1gray, I2gray, cameraParams) 

%%
lines = epipolarLine(F,points)
lines = epipolarLine(F',points)


end