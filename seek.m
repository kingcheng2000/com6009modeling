function [steer_result] = seek(agt, target_pos)
% Takes an agent, finds their location, outputs a new direction based on an
% attempt to get towards that position.

    origin_pos = agt.pos;
    
    desired_vec = target_pos - origin_pos;

    desired_vec = desired_vec / norm(desired_vec);

    desired_vec = desired_vec * agt.max_speed;
    steer_result = agt.steer(desired_vec);

end

