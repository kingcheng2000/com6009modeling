function [agent]=create_agents(nc,nh)

 %creates the objects representing each agent
 
%agent - cell array containing list of objects representing agents
%nc - number of copepods
%nh - number of herring

%global parameters
%ENV_DATA - data structure representing the environment (initialised in
%create_environment.m)
%MESSAGES is a data structure containing information that agents need to
%broadcast to each other
%PARAM - structure containing values of all parameters governing agent
%behaviour for the current simulation
 
 global ENV_DATA MESSAGES PARAM 
  
bm_size=ENV_DATA.bm_size;
cloc=((bm_size-1))*rand(nc,2)+1;     %generate random initial positions for copepods
hloc=((bm_size-1))*rand(nh,2)+1;      %generate random initial positions for herring
hvec = (bm_size/20) * rand(nh,2); % Setting the speed of the herring


MESSAGES.pos=[cloc;hloc];

fast_copes = 0.15;
slow_copes = 0.05;

fast_burst = 11;
slow_burst = 7;
%Bursts 0.45cm/s for 0.02s Decay till 0.3cm/s over 0.02s, Then 0.45cm/s for
%0.02s Decay till 0.15cm/s over 0.02s, Then 0.25cm/s for 0.02s Decay till swimming speed over 0.02s 

fast_herring = 134.0;
slow_herring = 70.0;

%generate all copepod agents and record their positions in ENV_MAT_C
for c=1:nc
    pos=cloc(c,:);

    vel=[0;0];
    
    % 0.1 -0.5 cm/s
    max_speed = rand_between(slow_copes, fast_copes);

    burst_speed = rand_between(slow_burst, fast_burst);
    
    agent{c}=copepod(pos,vel,max_speed,burst_speed);
end

%generate all herring agents and record their positions in ENV_MAT_H
for h=nc+1:nc+nh
    pos=hloc(h-nc,:);
    %create herring agents with random ages between 0 and 10 days and random
    %food levels 20-40
    vel = hvec(h-nc,:);
    max_speed = rand_between(slow_herring, fast_herring);
    % Not really using max_hunt_speed
    max_hunt_speed = 30;
    
    agent{h}=herring(pos, vel, max_speed, max_hunt_speed);
end
