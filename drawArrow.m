function [] = drawArrow( start_xy, end_xy )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

arrow_scaling = 0.5;
norm_end_xy = end_xy/arrow_scaling;

x = start_xy(1);
y = start_xy(2);
u = norm_end_xy(1);
v = norm_end_xy(2);

quiver( x, y, u, v )
hold on

end

