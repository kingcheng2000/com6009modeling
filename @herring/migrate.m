function [agt]=migrate(agt,cn)

%migration functions for class HERRING
%agt=herring object
%cn - current agent number

%SUMMARY OF HERRING MIGRATE RULE
%If a herring has not eaten, it will pick a random migration direction
%If it will leave the edge of the model, the direction is incremented by 45
%degrees at it will try again (up to 8 times)
%modified by D Walker 11/4/08

global IT_STATS N_IT ENV_DATA MESSAGES PARAM

%N_IT is current iteration number
%IT_STATS is data structure containing statistics on model at each
%iteration (no. agents etc)
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
nearby_copepods = extract_local_agents(agt,sense_radius,1);
% TODO(Pierre): We need something like MESSAGES.Vect, which contains all
% the vectors for the 

% TODO(Pierre): We might need to do 3 for loops. Like maybe the separation
% force only comes into play with agents closer than 3, wheras align comes
% into play with agents closer than 5, wheras cohes comes in closer than 7,
% or something.
sep_radius = PARAM.herring_desired_sep;
align_radius = 0.7 * sense_radius;
cohes_radius = 1 * sense_radius;

% Separation force:
tot_sep_force = [0.0,0.0];
% Alignment force:
tot_align_force = [0.0,0.0];
% Cohesion force:
tot_cohes_force = [0.0, 0.0];  

align_sum = [0.0, 0.0];
align_count = 0;

for fish = 1:length(nearby_herring)
    
    fish_i = nearby_herring(fish);
    % Separation force:
    tot_sep_force = tot_sep_force + agt.calc_sep_force(fish_i, sep_radius);
    
    % Alignment force:
    align_force = agt.calc_align_force(fish_i, align_radius);
    if align_force ~= [0.0,0.0]
        align_count = align_count + 1;
        align_sum = align_sum + align_force;
    end 
    
end

% Cohesion force:
tot_cohes_force = tot_cohes_force + agt.calc_cohesion_force(nearby_herring);  

% Final align force
if align_count > 0
    tot_align_force = align_sum./align_count;
else
    tot_align_force = [0.0,0.0];
end
% tot_sep_force
% tot_align_force
% tot_cohes_force

tot_hunt_force = agt.calc_hunt_force( nearby_copepods );

hunt_weight = PARAM.hunt_weight;
sep_weight = PARAM.sep_weight;
align_weight = PARAM.align_weight;
cohes_weight = PARAM.cohes_weight;

overall_force = (sep_weight * tot_sep_force) + (align_weight * tot_align_force) + (cohes_weight * tot_cohes_force) + (hunt_weight * tot_hunt_force);
% BUG(Pierre): Looks like some of these vels are getting set to 0 at the
% start for some reason? Maybe getting the indexes wrong/confused with
% copepods?



movement_vect = agt.steer(overall_force);

% If it has no reason to go anywhere, it will explore randomly.
if movement_vect == [0.0, 0.0]
    explore_speed = agt.max_speed * 0.5;
    min_explore = -explore_speed;
    max_explore = explore_speed;
    
    rand_x = rand_between(min_explore, max_explore);
    rand_y = rand_between(min_explore, max_explore);
    explore_force = [rand_x, rand_y];
    
    movement_vect = agt.steer(explore_force);
end
% BUG(Pierre): Something is going wrong in steer, where the first value is
% never negative.
agt.vel = movement_vect;

agt.pos = agt.pos + agt.vel;

% TODO(Pierre): Some function that Steers based on force. Like it
% shouldn't turn too fast or go faster than herring can go.
% Desired velocity, current velocity
% new_vel = steer(agt.vel, overall_force)
% pos = agt.pos + new_vel
  
% bm=ENV_DATA.bm_size;   
% vel=agt.speed;   %herring migration speed in units per iteration - this is equal to the food search radius
% pos=agt.pos;     %extract current position 
% 
% mig=0;
% cnt=1;
% dir=rand*2*pi;              %herring has been unable to find food, so chooses a random direction to move in
% 
% 
% while mig==0&cnt<=8        %herring has up to 8 attempts to migrate (without leaving the edge of the model)
%     
%     npos(1)=pos(1)+vel*cos(dir);        %new x co-ordinate
%     npos(2)=pos(2)+vel*sin(dir);        %new y co-ordinate
%     if npos(1)<ENV_DATA.bm_size&npos(2)<ENV_DATA.bm_size&npos(1)>=1&npos(2)>=1   %check that herring has not left edge of model - correct if so.
%        mig=1;
%     end
%     cnt=cnt+1;
%     dir=dir+(pi/4);         %if migration not successful, then increment direction by 45 degrees and try again
% end
% 
% if mig==1
%     agt.pos=npos;                    %update agent memory
%     IT_STATS.mig(N_IT+1)=IT_STATS.mig(N_IT+1)+1;    %update model statistics
% end


    
   
