function [agt]=escape(agt,cn)

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

sense_radius = agt.get('sense_radius');
% NOTE(Pierre): This generates an array of all of the agents that are
% within sensing radius.
nearby_herring = extract_local_agents(agt,sense_radius,2);

if length(nearby_herring) ~= 0
    pos=agt.pos;                         %extract current position 
    % cpos=round(pos);                     %round up position to nearest grid point   
    % TODO: Tune this value
    escape_speed = agt.burst_speed;
    rand_x = rand_between(-1,1);
    rand_y = rand_between(-1,1);
    rand_vect = [rand_x, rand_y];
    rand_norm_vect = rand_vect/norm(rand_vect);
    escape_vel = rand_norm_vect .* escape_speed;
    new_pos = [pos(1) + escape_vel(1), pos(2) + escape_vel(2)];
    agt.pos = new_pos;
end
   
   
