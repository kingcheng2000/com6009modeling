function [agt]=escape(agt,cn)

%escape functions for class COPEPOD
%agt=copepod object
%cn - current agent number

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
    pos=agt.pos;                         %extract current position  to nearest grid point   
    % TODO: Tune this value
    escape_speed = agt.burst_speed;
    rand_x = rand_between(-1,1);
    rand_y = rand_between(-1,1);
    rand_vect = [rand_x, rand_y];
    rand_norm_vect = rand_vect/norm(rand_vect);
    escape_vel = rand_norm_vect .* escape_speed;
    agt.vel = escape_vel;
    new_pos = [pos(1) + escape_vel(1), pos(2) + escape_vel(2)];
    agt.pos = new_pos;
end
   
   
