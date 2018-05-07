clear;
tic        %????
FishNum=20;%??10????
Max_gen=200;%??????
trynumber=500;%??????
Visual=8;%????
deta=0.8;% ?????
% CityPosition=[16.47,96.10; %????????14???????????????
%               16.47,94.44;
%               20.09,92.54;
%               22.39,93.37;
%               25.23,97.24; 
%               22.00,96.05;
%               20.47,97.02;
%               17.20,96.29;
%               16.30,97.38;
%               14.05,98.12;
%               16.53,97.38;
%               21.52,95.59;
%               19.41,97.13;
%               20.09,94.55];
CityPosition=[
37 ,52;
49 ,49;
52 ,64;
20 ,26;
40 ,30;
21 ,47;
17 ,63;
31 ,62;
52 ,33;
51 ,21;
42 ,41;
31 ,32;
  5, 25;
12 ,42;
36 ,16;
52 ,41;
27 ,23;
17 ,33;
13 ,13;
57 ,58;
62 ,42;
42 ,57;
16 ,57;
8 , 52;
7 , 38;
27 ,68;
30 ,48;
43 ,67;
58 ,48;
58 ,27;
37 ,69;
38 ,46;
46 ,10;
61 ,33;
62 ,63;
63 ,69;
32 ,22;
45 ,35;
59 ,15;
5  , 6;
10 ,17;
21 ,10;
5  ,64;
30 ,15;
39 ,10;
32 ,39;
25 ,32;
25 ,55;
48 ,28;
56 ,37;
30 ,40];
CityNum=length(CityPosition);%????
DNAN=100;                   %????????????????
for i=1:CityNum              %????????
     edge(i,i)=DNAN;
     for j=i+1:CityNum
         edge(i,j)=sqrt(sum((CityPosition(i,:)-CityPosition(j,:)).^2));
         edge(j,i)=edge(i,j);
     end
end
for i=1:FishNum             %???????????
     X(i,:)=Inital(CityNum);
end
Best=1000;
for NC=1:Max_gen
     Besty(NC)=1000;
     for i=1:FishNum
         [Xi,flag1]=follow(X,FishNum,Visual,deta,i,edge);%??????
         if(flag1==0) %????
             Visual2=floor(Visual*(1-NC/Max_gen));
             [Xi,flag2]=prey(X,CityNum,i,Visual,trynumber,edge);%?????
             if(flag2==0) %????
                   [Xi,flag3]=swarm(X,FishNum,CityNum,Visual,deta,i,edge);%?????
                   if(flag3==0)%????
                        Xi=X(i,:);%??????????????????
                   end
               end
           end
           X(i,:)=Xi;
           Yi=evaluate(Xi,edge);
           if(Yi<Besty(NC))
               Besty(NC)=Yi;%?????
           end
           if(Yi<Best)
               Best=Yi;     %?????
               Bestpath=Xi;
           end
                          
       end
          disp(['?',num2str(NC),'???,???????',num2str(Besty(NC))]);
   end
   t_train=toc;%????
   s=num2str(Bestpath(1));
   for i=2:CityNum
       s=strcat(s,'->');
       s=strcat(s,num2str(Bestpath(i)));
   end
   s=strcat(s,'->');
   s=strcat(s,num2str(Bestpath(1)));
   disp(['???????:',s,',???:',num2str(Best)]);
   plot(Besty);
   title(['???????????',num2str(Best),',???:',num2str(t_train),'?']);%x?
   text(floor(Max_gen/2),44,'????????????');
   xlabel('????');
   ylabel('???');
