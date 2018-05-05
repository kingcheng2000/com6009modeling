function lhl_AF
clc;clear all; close all;

format long
Visual = 2.5;   %????????
Step = 0.3;     %??????????
N = 10;         %??????
Try_number = 50;%???????
delta=0.618;     %?????
a1 = -10; b1 = 10; a2 = -10; b2 = 10; 
d = [];%??50??????????;
k = 0; 
m = 50;%????
X1 = rand(N,1)*(b1-a1)+a1;  %?-10~10???????50???
X2 = rand(N,1)*(b2-a2)+a2;
X = [X1 X2]; 
%X = ones(N,2);
%for i = 1:N
%    X(i,1)=-10;
%    X(i,2)=10;
%end
% ?????,??????X1?X2?

%??50????????
for i = 1:N
    www = [X(i,1),X(i,2)];
    d(i) = maxf(www);   
end
%???????????????????
[w,i] = max(d);         % ???????????w???????i?
maxX = [X(i,1),X(i,2)]; % ??????????????
maxY = w;               % ?????????????

figurex = []; figurey = []; figurez = [];

figurex(numel(figurex)+1) = maxX(1);    % ?maxX?1???figurex??
figurey(numel(figurey)+1) = maxX(2);    % numel?????????????????matlab????????1???
figurez(numel(figurez)+1) = maxY;

while(k<m)
    for i = 1:N
        XX = [X(i,1),X(i,2)];   %?????????????????
        
%%%%%%????????????????????????????
%???????????????????????????
%????????maxf?Xc????????????
        nf1=0;
        Xc=0;
        label_swarm =0;  %????????
        for j = 1:N 
            XX_1 = [X(j,1), X(j,2)];        
            if (norm(XX_1-XX)<Visual)  % norm?????XXX-XX???????????2???????        
                nf1 = nf1+1;     
                Xc = Xc+XX_1;      
            end    
        end
        Xc=Xc-XX;   %????XX???       
        nf1=nf1-1;
        Xc = Xc/nf1; %??Xc??XX??????????????  
        if((maxf(Xc)/nf1 > delta*maxf(XX)) && (norm(Xc-XX)~=0))  
            XXR1=rand*Step*(Xc-XX)/norm(Xc-XX);
            XXnext1=XX+XXR1;
            
            if(XXnext1(1) > b1)          
                XXnext1(1) = b1;      
            end
            if(XXnext1(1) < a1)    
                XXnext1(1) = a1;   
            end
            if(XXnext1(2) > b2)       
                XXnext1(2) = b2;      
            end
            if(XXnext1(2) < a2)     
                XXnext1(2) = a2;  
            end
            label_swarm =1;
            temp_y_XXnext1=maxf(XXnext1);  
        else 
            label_swarm =0;
            temp_y_XXnext1=-inf;
        end
        
%%%%%%
%%%%%%?????????? ???????????????????????
%?????????????????
        temp_maxY = -inf;  %??????????????-????
        label_follow =0;%????????
        for j = 1:N     
            XX_2 = [X(j,1),X(j,2)];      
            if((norm(XX_2-XX)<Visual) && (maxf(XX_2)>temp_maxY))       
                temp_maxX = XX_2;      
                temp_maxY = maxf(XX_2);     
            end
        end
        nf2=0;
        for j = 1:N     
            XX_2 = [X(j,1),X(j,2)];      
            if(norm(XX_2-temp_maxX)<Visual)       
                nf2=nf2+1;
            end
        end
        nf2=nf2-1;%?????
        
        if((temp_maxY/nf2)>delta*maxf(XX) && (norm(temp_maxX-XX)~=0))  %???Yj????????????     
            XXR2=rand*Step*(temp_maxX-XX)/norm(temp_maxX-XX);%rand????????????
            XXnext2 = XX+XXR2;  
            
            if(XXnext2(1) > b1)          
                XXnext2(1) = b1;      
            end
            if(XXnext2(1) < a1)    
                XXnext2(1) = a1;   
            end
            if(XXnext2(2) > b2)       
                XXnext2(2) = b2;      
            end
            if(XXnext2(2) < a2)     
                XXnext2(2) = a2;  
            end
            label_follow =1;
            temp_y_XXnext2=maxf(XXnext2);
        else    
            label_follow =0;
            temp_y_XXnext2=-inf;
        end       
%%%%%%
%%%%%%?????????????????????????????????????????????
%???????????????????XX_3?XX_4?????

%??????????????????????????????????????????????????????
        label_prey =0;    %?????????????????
        for j = 1:Try_number
            R1V=Visual*(-1+2*rand(2,1)');
            XX_3 = XX+R1V;
            if(XX_3(1) > b1) % ??????????????????????????                   
                XX_3(1) = b1;                  
            end
            if(XX_3(1) < a1)      
                XX_3(1) = a1;             
            end
            if(XX_3(2) > b2)        
                XX_3(2) = b2;              
            end
            if(XX_3(2) < a2)      
                XX_3(2) = a2;       
            end
            
            if(maxf(XX)<maxf(XX_3))
                XXR3=rand*Step*(XX_3-XX)/norm(XX_3-XX);
                XXnext3 = XX+XXR3;
                if(XXnext3(1) > b1) % ??????????????????????????                   
                    XXnext3(1) = b1;                  
                end
                if(XXnext3(1) < a1)      
                    XXnext3(1) = a1;             
                end
                if(XXnext3(2) > b2)        
                    XXnext3(2) = b2;              
                end
                if(XXnext3(2) < a2)      
                    XXnext3(2) = a2;       
                end
                label_prey =1;
                break;
            end   
        end
        temp_y_XXnext3=max(XXnext3);
        if(label_prey ==0)
            temp_y_XXnext3=-inf;
        end
%%%%%%
%%%%%%????
        if((label_swarm==0) && (label_follow==0) && (label_prey ==0))
            %?????????????????????????????????????
            %????????????????????????
            R2S=Step*(-1+2*rand(2,1)');
            temp_XX = XX+R2S;
            if(XX(1) > b1) % ??????????????????????????                              
                XX(1) = b1;               
            end
            if(XX(1) < a1)   
                XX(1) = a1;             
            end
            if(XX(2) > b2)     
                XX(2) = b2;             
            end
            if(XX(2) < a2)  
                XX(2) = a2;       
            end            
        else
            %???????
            if(temp_y_XXnext1 > temp_y_XXnext2)
                if(temp_y_XXnext1 > temp_y_XXnext3)   
                    temp_XX = XXnext1;
                else
                    temp_XX = XXnext3;
                end
            else
                if(temp_y_XXnext2 > temp_y_XXnext3)
                    
                    temp_XX = XXnext2;
                else
                    temp_XX = XXnext3;
                end
            end         
        end
        XX=temp_XX;
        X(i,1) = XX(1);
        X(i,2) = XX(2); 
%%%%%%
    end
    %????????????????????
    
    %??????????
    for i = 1:N
        XXX = [X(i,1),X(i,2)];
        if (maxf(XXX)>maxY)
            maxY = maxf(XXX);
            maxX = XXX;
            figurex(numel(figurex)+1) = maxX(1);
            figurey(numel(figurey)+1) = maxX(2);
            figurez(numel(figurez)+1) = maxY;
        end
    end
    x=X(:,1)';
    y=X(:,2)';
    plot(x,y,'*r');
    axis([-10 10 -10 10]); 
    k = k+1
end
maxX
maxY
plot3(figurex,figurey,figurez,'-g.')




function y = maxf(QQ)
%????y=(sinX1/X1)*(sinX2/X2),?????????????
%????????????

y = (sin(QQ(1))/QQ(1))*(sin(QQ(2))/QQ(2));




