function [Point_cell, Seq_cell] = BCC2TCubeGenerator_7(L_cell,Var,Dirct)
% clc
% clear
% L_cell=20
% Var=[1 1 1 1, 1 1 1 1];
P_cell=[0 0 0];
% Dirct=1

Var_P(1)=mean(Var(1:8));
 

Point_cell(1:3,1)=[-0.5,-0.5,0]*L_cell/2.*[2-Var_P(1),2-Var_P(1),1];
Point_cell(1:3,2)=[ 0.5,-0.5,0]*L_cell/2.*[2-Var_P(1),2-Var_P(1),1];
Point_cell(1:3,3)=[-0.5, 0.5,0]*L_cell/2.*[2-Var_P(1),2-Var_P(1),1];
Point_cell(1:3,4)=[ 0.5, 0.5,0]*L_cell/2.*[2-Var_P(1),2-Var_P(1),1];
 
Point_cell(1:3,5)=[-1,-1,0]*L_cell/2.*[1,1,1];
Point_cell(1:3,6)=[ 1,-1,0]*L_cell/2.*[1,1,1];
Point_cell(1:3,7)=[-1, 1,0]*L_cell/2.*[1,1,1];
Point_cell(1:3,8)=[ 1, 1,0]*L_cell/2.*[1,1,1];

Point_cell(1:3,9)=[ 0,0,-0.5]*L_cell/2.*[1,1,2-Var_P(1)];
Point_cell(1:3,10)=[ 0,0,-1]*L_cell/2.*[1,1,1];
Point_cell(1:3,11)=[ 0,0,0.5]*L_cell/2.*[1,1,2-Var_P(1)];
Point_cell(1:3,12)=[ 0,0,1]*L_cell/2.*[1,1,1];
 

if Dirct==1
   RM_local=[1 0 0;
             0 1 0;
             0 0 1;];
elseif Dirct==2
    RM_local=[0 1 0;
              0 0 1;
              1 0 0;];
elseif Dirct==3
    RM_local=[0 0 1;
              1 0 0;
              0 1 0;];
end
Point_cell=RM_local*Point_cell; 
 
% hold on
% for ii=1:size(Point_cell,2)     
%     scatter3(P_cell(1)+Point_cell(1,ii), ...
%         P_cell(2)+Point_cell(2,ii), ...
%         P_cell(3)+Point_cell(3,ii),20,'r');
%     text(P_cell(1)+Point_cell(1,ii), ...
%         P_cell(2)+Point_cell(2,ii), ...
%         P_cell(3)+Point_cell(3,ii)+1,num2str(ii,2));
% end
% grid on
% axis equal
% xlabel('x')
% ylabel('y')
% zlabel('z')
%%
%non-shared
Seq_cell{1}=[ 1   9; 2   9; 3  9; 4  9;            
              1  11; 2  11; 3 11; 4 11;   
              1   5; 3   7; 4  8; 2  6;
              9  10; 11 12;];%%non-shared

%shared in local Face X 
Seq_cell{2}{1}=[ ];%
Seq_cell{2}{2}=[ ];%

%shared in local Face Y 
Seq_cell{3}{1}=[ ];%
Seq_cell{3}{2}=[ ];%

%shared in local Face Z
Seq_cell{4}{1}=[ ]; 
Seq_cell{4}{2}=[ ];
%shared in local Face X and Y

Seq_cell{5}{1}=[ ];
Seq_cell{5}{2}=[ ];
Seq_cell{5}{3}=[ ];
Seq_cell{5}{4}=[ ];

%shared in local Face Y and Z
Seq_cell{6}{1}=[];
Seq_cell{6}{2}=[];
Seq_cell{6}{3}=[];
Seq_cell{6}{4}=[];

%shared in local Face X and Z
Seq_cell{7}{1}=[];
Seq_cell{7}{2}=[];
Seq_cell{7}{3}=[];
Seq_cell{7}{4}=[];

 

% hold on
% for ii=1:size(Seq_cell_1,1)
%     plot3(P_cell(1)+Point_cell(1,Seq_cell_1(ii,:)), ...
%           P_cell(2)+Point_cell(2,Seq_cell_1(ii,:)), ...
%           P_cell(3)+Point_cell(3,Seq_cell_1(ii,:)),'k',LineWidth=1)
% end
% 
% Seq_cell_2=reshape(pagetranspose(Seq_cell_2),2,[],1);
% Seq_cell_2=Seq_cell_2';
% 
% for ii=1:size(Seq_cell_2,1)    
%     plot3(P_cell(1)+Point_cell(1,Seq_cell_2(ii,:)), ...
%           P_cell(2)+Point_cell(2,Seq_cell_2(ii,:)), ...
%           P_cell(3)+Point_cell(3,Seq_cell_2(ii,:)),'k',LineWidth=1)
% end
% grid on
% hold off
% axis equal
% box on
% view([1 0.5 0.25])
% 
% xlabel('x')
% ylabel('y')
% zlabel('z')

end