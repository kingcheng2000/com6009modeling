function val=get(c,prop_name)

%standard function to allow extraction of memory parameters from copepod object

switch prop_name
   
case 'pos'
   val=c.pos;
case 'vel'
   val=c.vel;
case 'max_speed'
    val=c.max_speed;
case 'burst_speed'
     val=c.burst_speed;
case 'sense_radius'
     val = c.sense_radius;
otherwise 
   error('invalid field name')
end

