function [ movement_vect ] = steer(self, desired_vect)
%STEER This function limits the ability of the herring to change direction
% or velocity instantly.


global PARAM

max_turning_rate = PARAM.herring_max_turn_rate; % In degrees per iteration
max_accel = PARAM.herring_max_accel;
max_speed = self.max_speed;

curr_vect = self.vel;

curr_speed = norm(curr_vect);
desired_speed = norm(desired_vect);

% This gives the angle between the two vectors in degrees. Value between 0
% and 180
curr_desired_prod = curr_speed * desired_speed;
if curr_desired_prod > 0
    angle_diff = acosd(dot(curr_vect, desired_vect) / (curr_speed * desired_speed));
else
    angle_diff = 0;
end

if angle_diff > max_turning_rate
    % This gives the fraction of the difference between the two vectors to
    % move. If t = 0.5, the vector is half way between the two vectors
    t = max_turning_rate/angle_diff;
    desired_vect = [((1-t) * curr_vect(1)) + (t * desired_vect(1)),((1-t) * curr_vect(2)) + (t * desired_vect(2))];
    desired_speed = norm(desired_vect);
end

% Avoiding divide by zero mistakes
if desired_speed > 0
    unit_vect = desired_vect / desired_speed;
else
    unit_vect = desired_vect;
end

if desired_speed > max_speed
    desired_speed = max_speed;
end

% NOTE(Pierre): Not really sure about this. Idea is sometimes speed diff is
% pos, sometimes it's neg. If it's big, you want to accelerate a lot (but
% not more than max_accel)
speed_diff = (desired_speed-curr_speed)/max_speed;
final_accel = speed_diff * max_accel;

output_speed = curr_speed + final_accel;

movement_vect = output_speed * unit_vect;

end

