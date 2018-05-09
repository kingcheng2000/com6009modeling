classdef copepod   %declares copepod object

    properties    %define copepod properties (parameters) 
        pos;
        vel;
        max_speed;
        burst_speed;
        sense_radius;
    end
    methods                         %note that this class definition mfile contains only the constructor method!
                                    %all additional member functions associated with this class are included as separate mfiles in the @copepod folder. 
        function c=copepod(varargin) %constructor method for copepod - assigns values to copepod properties
                %c=copepod(age,food,pos....)
                %
                %age of agent (usually 0)
                %food - amount of food that copepod has eaten
                %pos - vector containg x,y, co-ords 

                %Modified by Martin Bayley on 29/01/13
                global PARAM;


                switch nargin           %Use switch statement with nargin,varargin contructs to overload constructor methods
                    case 0				%create default object
                       c.pos=[];
                       c.vel=[];
                       c.max_speed=[];
                       c.burst_speed=[];
                    case 1              %input is already a copepod, so just return!
                       if (isa(varargin{1},'copepod'))		
                            c=varargin{1};
                       else
                            error('Input argument is not a copepod')
                            
                       end
                    case 4             %create a new copepod (currently the only constructor method used)
                        c.pos=varargin{1};               %current position in Cartesian co-ords [x y]
                        c.vel=varargin{2};             %number of kilometres copepod can migrate in 1 day
                        c.max_speed=varargin{3};        %number of iterations since copepod last reproduced.
                        c.burst_speed=varargin{4};
                        c.sense_radius = PARAM.copepod_sense_radius;
                    otherwise
                       error('Invalid no. of input arguments')
                end
        end
    end
end
