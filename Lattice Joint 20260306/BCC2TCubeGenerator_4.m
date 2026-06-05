function [Point_cell, Seq_cell] = BCC2TCubeGenerator_4(L_cell,Var,Dirct)
% clc
% clear
% L_cell=20
% Var=[1 1 1 1, 1 1 1 1];
P_cell=[0 0 0];
% Dirct=1

Var_P(1)=mean(Var([1 3 5 7] ));
Var_P(2)=mean(Var([2 4 6 8] ));

Point_cell(1:3,1)=[ 0,-1,-1]*L_cell/2.*[1,1,1];
Point_cell(1:3,2)=[ 0, 1,-1]*L_cell/2.*[1,1,1];

Point_cell(1:3,3)=[ 0, -1,  -0.5]*L_cell/2.*[1, 1, 2-Var_P(1)];
Point_cell(1:3,4)=[  0, 1, -0.5]*L_cell/2.*[1, 1, 2-Var_P(2)];

Point_cell(1:3,5)=[ -0.5, -0.5,0]*L_cell/2.*[2-Var_P(1) Var_P(1), 1];
Point_cell(1:3,6)=[  0.5, -0.5,0]*L_cell/2.*[2-Var_P(1) Var_P(1), 1];
Point_cell(1:3,7)=[ -0.5,  0.5,0]*L_cell/2.*[2-Var_P(2) Var_P(2), 1];
Point_cell(1:3,8)=[  0.5,  0.5,0]*L_cell/2.*[2-Var_P(2) Var_P(2), 1];

Point_cell(1:3,9)=[-1, 0,  0]*L_cell/2.*[1,1, 1];
Point_cell(1:3,10)=[ 1, 0,0]*L_cell/2.*[1,1, 1];


Point_cell(1:3,11)=[0, -1, 1]*L_cell/2.*[1,1,1];
Point_cell(1:3,12)=[0, 1,  1]*L_cell/2.*[1,1,1];

Point_cell(1:3,13)=[ 0, -1, 0.5]*L_cell/2.*[1, 1, 2-Var_P(1)];
Point_cell(1:3,14)=[ 0,  1, 0.5]*L_cell/2.*[1, 1, 2-Var_P(2)];

 


 

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
Seq_cell{1}=[5 3;  5 13; 6 3; 6 13; 
             7 4;  7 14; 8 4; 8 14; 
             5 9; 7 9; 6 10 ; 8 10];%

%shared in local Face X 
Seq_cell{2}{1}=[ ];%
Seq_cell{2}{2}=[ ];%


%shared in local Face Y 

Seq_cell{3}{1}=[1 3; 11 13];% 
Seq_cell{3}{2}=[2 4; 12 14 ];%

%shared in local Face Z
Seq_cell{4}{1}=[ ];%
Seq_cell{4}{2}=[ ];;%

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