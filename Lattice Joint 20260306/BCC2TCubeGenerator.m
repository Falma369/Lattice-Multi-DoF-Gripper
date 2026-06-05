function [Point_cell, Seq_cell] = BCC2TCubeGenerator(L_cell,Var,P_cell)
% L_cell=20
% Var=[1 1 1 1, 1 1 1 1];
% P_cell=[0 0 0]
Point_cell(1:3,1)=[0,0,-1]*L_cell/2;
Point_cell(1:3,2)=[-0.5,-0.5,-1]*L_cell/2.*[Var(1),Var(1),1];
Point_cell(1:3,3)=[0.5,-0.5,-1]*L_cell/2.*[Var(2),Var(2),1];
Point_cell(1:3,4)=[-0.5,0.5,-1]*L_cell/2.*[Var(3),Var(3),1];
Point_cell(1:3,5)=[0.5,0.5,-1]*L_cell/2.*[Var(4),Var(4),1];

Point_cell(1:3,6)=[-1,-1,-0.5]*L_cell/2.*[1,1,Var(1)];
Point_cell(1:3,7)=[1,-1,-0.5]*L_cell/2.*[1,1,Var(2)];
Point_cell(1:3,8)=[-1,1,-0.5]*L_cell/2.*[1,1,Var(3)];
Point_cell(1:3,9)=[1,1,-0.5]*L_cell/2.*[1,1,Var(4)];

Point_cell(1:3,10)=[0,0,1]*L_cell/2;
Point_cell(1:3,11)=[-0.5,-0.5,1]*L_cell/2.*[Var(5),Var(5),1];
Point_cell(1:3,12)=[0.5,-0.5,1]*L_cell/2.*[Var(6),Var(6),1];
Point_cell(1:3,13)=[-0.5,0.5,1]*L_cell/2.*[Var(7),Var(7),1];
Point_cell(1:3,14)=[0.5,0.5,1]*L_cell/2.*[Var(8),Var(8),1];

Point_cell(1:3,15)=[-1,-1,0.5]*L_cell/2.*[1,1,Var(5)];
Point_cell(1:3,16)=[1,-1,0.5]*L_cell/2.*[1,1,Var(6)];
Point_cell(1:3,17)=[-1,1,0.5]*L_cell/2.*[1,1,Var(7)];
Point_cell(1:3,18)=[1,1,0.5]*L_cell/2.*[1,1,Var(8)];



% hold on
% for ii=1:size(Point_cell,2)     
%     scatter3(P_cell(1)+Point_cell(1,ii), ...
%         P_cell(2)+Point_cell(2,ii), ...
%         P_cell(3)+Point_cell(3,ii),20,'r');
%     text(P_cell(1)+Point_cell(1,ii), ...
%         P_cell(2)+Point_cell(2,ii), ...
%         P_cell(3)+Point_cell(3,ii)+1,num2str(ii,2));
% end


Seq_cell_1=[2 6;3 7;4 8;5 9;11 15;12 16;13 17;14 18];%%non-shared
%shared in X Y
Seq_cell_2{1}=[8 17];
Seq_cell_2{2}=[9 18];
Seq_cell_2{3}=[7 16];
Seq_cell_2{4}=[6 15];
%shared in Z
Seq_cell_2{5}=[1 2;1 3;1 4;1 5];
Seq_cell_2{6}=[1 2;1 3;1 4;1 5]+9;

Seq_cell={Seq_cell_1, Seq_cell_2};

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