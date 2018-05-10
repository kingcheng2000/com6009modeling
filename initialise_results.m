function initialise_results(nc,nh,nsteps)

 global  IT_STATS
 
%set up data structure to record statistics for each model iteration
%IT_STATS  -  is data structure containing statistics on model at each
%iteration (number of agents etc)
%ENV_DATA - data structure representing the environment 
 
 IT_STATS=struct('eaten',[zeros(1,nsteps+1)],...              %no. copepods eaten per iteration
                'tot',[zeros(1,nsteps+1)],...				%total no. agents in model per iteration
                'tot_c',[zeros(1,nsteps+1)],...             % total no. copepods
                'tot_h',[zeros(1,nsteps+1)]);
            
 
 IT_STATS.tot(1)=nc+nh;
 IT_STATS.tot_c(1)=nc;
 IT_STATS.tot_h(1)=nh;
