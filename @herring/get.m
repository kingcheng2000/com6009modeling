function val=get(c,prop_name)

%standard function to allow extraction of memory parameters from herring object

switch prop_name
   
case 'pos'
   val=c.pos;
case 'vel'
   val=c.vel;
case 'max_speed'
    val=c.max_speed;
case 'max_hunt_speed'
     val=c.max_hunt_speed;
case 'sense_radius'
     val = c.sense_radius;
otherwise 
   error('invalid field name')
end

