function [agt]=migrate(agt,cn)

%migration functions for class COPEPOD
%agt=copepod object
%cn - current agent number

%SUMMARY OF COPEPOD MIGRATE RULE
%Copepods will migrate only if they have not eaten
%Copepods will always try to migrate towards the nearest food source
%The copepod will extract the distibution of food in its LOCAL environment (at
%distances < its daily migration limit)
%It will identify the location of the nearest food and migrate into it.
%It's new position will be randomly placed within this square
%If no food is detected within its search radius it will move randomly (up
%to 8 atempts without leaving the model edge)

global ENV_DATA IT_STATS N_IT 
%N_IT is current iteration number
%IT_STATS is data structure containing statistics on model at each
%iteration (no. agents etc)
%interpolated to each grid point
%ENV_DATA is a data structure containing information about the model
   %environment
   %    ENV_DATA.shape - shape of environment - FIXED AS SQUARE
   %    ENV_DATA.units - FIXED AS KM
   %    ENV_DATA.bm_size - length of environment edge in km
   %    ENV_DATA.food is  a bm_size x bm_size array containing distribution
   %    of food

pos=agt.pos;                         %extract current position 
% cpos=round(pos);                     %round up position to nearest grid point   

explore_speed = agt.max_speed * 100;
min_explore = -explore_speed;
max_explore = explore_speed;
rand_x = rand_between(min_explore, max_explore);
rand_y = rand_between(min_explore, max_explore);
explore_vel = [rand_x, rand_y];
explore_vel = (explore_vel/norm(explore_vel)) .* explore_speed;
    
    
new_pos = [pos(1) + explore_vel(1), pos(2) + explore_vel(2)];
agt.pos = new_pos;