function create_params(her_sep, hunt_only)


%PARAM - structure containing values of all parameters governing agent
%behaviour for the current simulation

global PARAM

    PARAM.C_SPD=2;         %speed of movement - units per itn (copepod)
    PARAM.H_SPD=5;         %speed of movement - units per itn (herring)

    if hunt_only == false
        hunt_weight = 100;
        sep_weight = 800;
        align_weight = 40;
        cohes_weight = 60;
    else
        hunt_weight = 100;
        sep_weight = 0;
        align_weight = 0;
        cohes_weight = 0;
    end

    % This part is to make it so that they always sum to 1:
    total_weights = hunt_weight + sep_weight + align_weight + cohes_weight;
    
    PARAM.hunt_weight = hunt_weight/total_weights;
    PARAM.sep_weight = sep_weight/total_weights;
    PARAM.align_weight = align_weight/total_weights;
    PARAM.cohes_weight = cohes_weight/total_weights;
    
    
    PARAM.herring_max_turn_rate = 30; % In degrees per iteration
    PARAM.herring_max_accel = 10;
    
    % Probably shouldn't be more than 70ish
    PARAM.herring_desired_sep = her_sep;
    
    PARAM.copepod_sense_radius = 3;
