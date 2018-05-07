classdef herring          %declares herring object
    properties         %define herring properties (parameters) 
        pos;
        vel;
        max_speed;
        max_hunt_speed;
        body_size;
        sense_radius;
    end
    methods                         %note that this class definition mfile contains only the constructor method!
                                    %all additional member functions associated with this class are included as separate mfiles in the @herring folder. 
            function h=herring(varargin) %constructor method for herring  - assigns values to herring properties
                %h=herring(age,food,pos....)
                %
                %age of agent (usually 0)
                %food - amount of food that herring has eaten
                %pos - vector containg x,y, co-ords 

                %Modified by Martin Bayley on 29/01/13

            switch nargin                     %Use switch statement with nargin,varargin contructs to overload constructor methods
                case 0                        %create default object
                    h.pos=[];
                    h.max_speed=[];
                case 1                         %input is already a herring, so just return!
                    if (isa(varargin{1},'herring'))		
                        h=varargin{1};
                    else
                        error('Input argument is not a herring')
                    end
                case 4                         %create a new herring (currently the only constructor method used)
                    h.pos=varargin{1};               %current position in Cartesian co-ords [x y]
                    h.vel=varargin{2};
                    h.max_speed=varargin{3};             %number of cm herring can move in 1 second
                    h.max_hunt_speed=varargin{4};
                    % TODO: Set this randomly? Between 6 and 21.9
                    h.body_size = 14;
                    h.sense_radius = 5 * h.body_size;
                 
                otherwise
                    error('Invalid no. of input arguments for herring')
            end
        end
    end
end