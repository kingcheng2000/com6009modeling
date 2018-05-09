function [nagent,nn]=agnt_solve(agent)

%sequence of functions called to apply agent rules to current agent population.
%%%%%%%%%%%%
%[nagent,nn]=agnt_solve(agent)
%%%%%%%%%%%
%agent - list of existing agent structures
%nagent - list of updated agent structures
%nn - total number of live agents at end of update

%Created by Dawn Walker 3/4/08 

n=length(agent);    %current no. of agents
prev_n=n;   %remember current agent number at the start of this iteration

%execute existing agent update loop
for cn=1:n
	curr=agent{cn};
    if isa(curr,'copepod')|isa(curr,'herring')
        if isa(curr,'herring')
            [curr]=eat(curr,cn);               %eating rules (copepods eat food, herring eat copepods)
        end
        if isa(curr,'copepod')
            [curr]=escape(curr,cn);               %eating rules (copepods eat food, herring eat copepods)
        end
        curr=migrate(curr,cn);              %if no food was eaten, then migrate in search of some
       agent{cn}=curr;                          %up date cell array with modified agent data structure
    end
end

temp_n=n; %new agent number (before accounting for agent deaths) TODO(Pierre): Can we just use prev n?
[nagent,nn]=update_messages(agent,prev_n,temp_n);   %function which update message list and 'kills off' dead agents.

