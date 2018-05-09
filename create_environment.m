function create_environment(size)

%function that populates the global data structure representing
%environmental information

%ENV_DATA is a data structure containing information about the model
   %environment
   %    ENV_DATA.shape - shape of environment - FIXED AS SQUARE
   %    ENV_DATA.units - FIXED AS CM
   %    ENV_DATA.bm_size - length of environment edge in cm
   %    ENV_DATA.food is  a bm_size x bm_size array containing distribution
   %    of food

global ENV_DATA

ENV_DATA.shape='square';
ENV_DATA.units='cm';
ENV_DATA.bm_size=size;

