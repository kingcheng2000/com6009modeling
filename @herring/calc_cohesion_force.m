function [ output_force ] = calc_cohesion_force( self, other_nearby_agts )
% This function calculates the cohesion force between all nearby agents.
global MESSAGES

    neighbor_sum = [0.0, 0.0];
    count = 0;
    for fish = 1:length(other_nearby_agts)
        fish_pos = MESSAGES.pos(fish,:);
        neighbor_sum = neighbor_sum + fish_pos;
        count = count + 1;
    end
    
    if count > 0
        neighbor_average = neighbor_sum ./ count;
        
        output_force = seek(self, neighbor_average);
    else
        output_force = neighbor_sum;
    end
    

end

