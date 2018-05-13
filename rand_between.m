function [ output_args ] = rand_between( low, high )
% Extracts a random number based on a normal distribution, using the low
% and high as being 3 standard deviations apart.

    diff = high - low;
    mean = low + (diff / 2);
    % We make an assumption that the highest and lowest numbers are 3 standard
    % deviations from the mean
    stdev = diff/6;
    
    

  output_args = normrnd(mean, stdev);

end

