function [feature_coord,feature_descriptor] = Features(img)
%FEATURES Summary of this function goes here
%   This function detects features of a given image.
%   Inputs: An image array
%   Outputs: An n x 2 array feature_coord which stores feature coordinates
%   on the image where n is the number of features. An n x 128 array
%   feature_descriptor which stores feature descriptors.

image = 'IMG_0142.JPG';
img_gray = imread(image);
gaussian_kernel = fspecial('gaussian', [3 3], 1);
sobel_x = fspecial('sobel');
sobel_y = sobel_x';

i_x = filter2(sobel_x, img_gray);
i_y = filter2(sobel_y, img_gray);

f_xx = filter2(gaussian_kernel, i_x.* i_x);
f_xy = filter2(gaussian_kernel, i_x.* i_y);
f_yy = filter2(gaussian_kernel, i_y.* i_y);

CS = ((f_xx.* f_yy) - (f_xy.^2)) ./ (f_xx + f_yy + 1 * 10^-16);

[rows, cols] = nonmaxsuppts(CS, 2, 6000);

[num_of_features] = size(rows);

max_num_of_features = 1000;
% Treshold the number of features to 1000 (by random shuffling).
% Otherwise we get TOO MANY features for 'wall' images and the computation takes forever.
if num_of_features(1) > max_num_of_features
    permutations = randperm(num_of_features(1));
    random_match_indices = permutations(1:max_num_of_features);
    
    rows = rows(random_match_indices,:);
    cols = cols(random_match_indices,:);
end

end
