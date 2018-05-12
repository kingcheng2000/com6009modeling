function [agt]=migrate(agt,cn)

%migration functions for class COPEPOD
%agt=copepod object
%cn - current agent number


pos=agt.pos;                         %extract current position 
% cpos=round(pos);                     %round up position to nearest grid point   

% TODO: Tune this value
explore_speed = agt.max_speed;
min_explore = -explore_speed;
max_explore = explore_speed;
rand_x = rand_between(min_explore, max_explore);
rand_y = rand_between(min_explore, max_explore);
explore_vel = [rand_x, rand_y];
explore_vel = (explore_vel/norm(explore_vel)) .* explore_speed;
    
    
new_pos = [pos(1) + explore_vel(1), pos(2) + explore_vel(2)];
agt.pos = new_pos;