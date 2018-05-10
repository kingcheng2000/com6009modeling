function [agt]=eat(agt,cn)

%eating function for class HERRING
%agt=herring object
%cn - current agent number
%eaten = 1 if herring successfully finds a copepod, =0 otherwise

%SUMMARY OF HERRING EAT RULE
%Herring calculates distance to all copepods
%Herring identifies nearest copepod(s)
%If more than one equidistant within search radius, one is randomly picked
%Probability of herring killing copepod =1 - distance of copepod/speed of
%herring
%If probability > rand, herring moves to copepod location and copepod is
%killed
%If herring does not kill copepods, its food is decremented by one unit

%GLOBAL VARIABLES
%N_IT is current iteration number
%IT_STATS is data structure containing statistics on model at each
%iteration (no. agents etc)
%MESSAGES is a data structure containing information that agents need to
%broadcast to each other
   %    MESSAGES.atype - n x 1 array listing the type of each agent in the model
   %    (1=copepod, 2=herring, 3=dead agent)
   %    MESSAGES.pos - list of every agent position in [x y]
   %    MESSAGE.dead - n x1 array containing ones for agents that have died
   %    in the current iteration
   
     
%Modified by D Walker 3/4/08

global  IT_STATS N_IT MESSAGES
   
eat_radius = 2;
local = extract_local_agents(agt, eat_radius, 1);

if length(local)>0
    if length(local)>1       %if more than one copepod located at same distance then randomly pick one to head towards
            s=round(rand*(length(local)-1))+1;
            nrst=local(s);
    else
        nrst = local; %If length is not more than 1, must be exactly 1
    end

    IT_STATS.eaten(N_IT+1) = IT_STATS.eaten(N_IT+1) + 1; %update model statistics
    MESSAGES.dead(nrst)=1;       %send message to copepod so it knows it's dead!
end





   
