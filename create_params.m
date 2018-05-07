function create_params


%PARAM - structure containing values of all parameters governing agent
%behaviour for the current simulation

global PARAM

    PARAM.C_SPD=2;         %speed of movement - units per itn (copepod)
    PARAM.H_SPD=5;         %speed of movement - units per itn (herring)

    hunt_weight = 60;
    sep_weight = 50;
    align_weight = 25;
    cohes_weight = 10;

    % This part is to make it so that they always sum to 1:
    total_weights = hunt_weight + sep_weight + align_weight + cohes_weight;
    
    PARAM.hunt_weight = hunt_weight/total_weights;
    PARAM.sep_weight = sep_weight/total_weights;
    PARAM.align_weight = align_weight/total_weights;
    PARAM.cohes_weight = cohes_weight/total_weights;