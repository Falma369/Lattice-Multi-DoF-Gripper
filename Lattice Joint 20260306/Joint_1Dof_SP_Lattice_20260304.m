%使用插值离散法生成每个元胞的结构参数
clc
clear
close all
% Define the left and right ligament width
w_L=2.5;%0-2.5, step 0.5
w_R=-1.5;%0-2.5, step 0.5
% Define the Joint offset
Offset_J=2;% 0 1 2
%Define the joint highet
N_H=3;
% define the anisotropy and distribution of the lattice

% Cell_Offset_ANI=[0 0 4 6];% 0- body centre(0 0 0);1- face centre(0.5, 0 ,0);2- face centre(0, 0.5, 0); 3- face centre(0 0 0.5); 4- edge middle-1(0 0.5 0.5); 5- edge middle-2( 0.5 0 0.5)：6- edge middle-2(0.5 0.5  0)， 7- edge middle-2(0.5 0.5 0.5)
% Drict_ANI=[2 3 2 1];% 1 means the XYZ frame 2: ZXY 3: YZX
% N_cell_M=[2 2 4; 2 2 2; 2 2 2; 2 2 2;] 
% Center_Body_M=[0 0 0;0 0 0; 0 0 0; 0 0 0];

Cell_Offset_ANI=[3 1 1 1];% 0- body centre(0 0 0);1- face centre(0.5, 0 ,0);2- face centre(0, 0.5, 0); 3- face centre(0 0 0.5); 4- edge middle-1(0 0.5 0.5); 5- edge middle-2( 0.5 0 0.5)：6- edge middle-2(0.5 0.5  0)， 7- edge middle-2(0.5 0.5 0.5)
Drict_ANI=[3 3 2 1];% 1 means the XYZ frame 2: ZXY 3: YZX
N_cell_M=[5 4 N_H; 5 4 N_H; 5 4 N_H; 5 4 N_H;] 

% N_cell_M=[3 4 4; 3 4 4;3 4 2; 3 4 4;] 
Center_Body_M=[0 0 0; 0 0 0; 0 0 0; 0 0 0];

% define the topology and thickness feild 
 
Truss_lattice_M=[]
Thick_truss_lattice_M=[]
Point_lattice_M=[ ];
Thick_point_lattice_M=[ ];
for Index_ANI=[ 2 3 4]      %:length(Cell_Offset_ANI) Tifff -> on peut aussi ne pas avoir le TPU ou dautre partie en faisant comme ça : Index_ANI=[ 2 3 4]

    L_cell=5;
    N_cell=N_cell_M(Index_ANI,:);%cell number in length width and height
    L_lattice=L_cell*N_cell;
    
    Center_Body=Center_Body_M(Index_ANI,:);

    Index_Offset=Cell_Offset_ANI(Index_ANI);
    % generate the topology feild of the structure.
    [Xq,Yq,Zq]=meshgrid(linspace(-0.5,0.5,N_cell(1)+1),linspace(-0.5,0.5,N_cell(2)+1),linspace(-0.5,0.5,N_cell(3)+1));

    X=Xq
    Y=Yq;
    Z=Zq;

    R_xy=   sqrt(Xq.^2+Yq.^2);
    R_edge= sqrt(0.5.^2+0.25.^2);

    if  Index_ANI==1
        Topl_index= Zq*0;     
        Thick_index=Zq*0+1;
        Offset_X=Y*L_lattice(1).*Zq*0.0
        Offset_Y=-X*L_lattice(2).*Zq*0.0        
        Offset_Z=0*Zq*L_lattice(3);
     
    
    elseif  Index_ANI==2
        Topl_index= 2+Zq*0; 
        Thick_index=Zq*0+1; 
        Offset_X=Y*L_lattice(1).*Zq*0.0
        Offset_Y=-X*L_lattice(2).*Zq*0.0 
%         Offset_Y = (-Yq*2+4);
        Offset_Z=0*Zq*L_lattice(3) ;
     

    elseif  Index_ANI==3
        Topl_index= 2+Zq*0; 
        Thick_index=Zq*0+1; 
        Offset_X=Y*L_lattice(1).*Zq*0.0;
        Offset_Y=Zq*0;
%         Offset_Y=(0.5+2.5)*(-Yq+0.5)+(8.5-7.5)*(Yq+0.5);         
        Offset_Z=0*Zq*L_lattice(3) ;
    else
        Topl_index= 2+Zq*0; 
        Thick_index=Zq*0+1; 
        Offset_X=Zq*0;
        Offset_Y=Zq*0;      
        Offset_Z=0*Zq;
    end



% 
%     % Topology feild
%     if  Index_ANI==1
%         Topl_index=0+ 0*(1.5+Xq+Yq+Zq);
%     elseif Index_ANI==2
%         Topl_index=2+ 0*(1.5+Xq+Yq+Zq);     
%     else  
%         Topl_index=2+ 0*(1.5+Xq+Yq+Zq);
%     end
% 
%      
%     % Thickness feild
%     if Index_ANI<=25
%        Thick_index=0.75+Zq*0;%-Zq*0.2+0.2*(Topl_index/2-0.5)
%     else
%       Thick_index=0.75+Zq*0;%-Zq*0.2+0.2*(Topl_index/2-0.5)
%     end
% 
% 
%     %Offset feild
%     Offset_X=(-Y*L_lattice(2).*Zq*0.25.*(0.5-Zq)+X*L_lattice(1)  ).*( (0.5-Zq)*(5.5/4.5)+(0.5+Zq)*(5/4.5) )-X*L_lattice(1);
%     Offset_Y=(X*L_lattice(2).*Zq*0.25.*(0.5-Zq)+Y*L_lattice(2) ).*( (0.5-Zq)*(5.5/4.5)+(0.5+Zq)*(5/4.5) )-Y*L_lattice(2);
%     Offset_X=X*0;
%     Offset_Y=Y*0;
%     Offset_Z=-(0/4.5)*Zq*L_lattice(3);
%  
 
    Xq=pagetranspose(Xq);
    Yq=pagetranspose(Yq);
    Zq=pagetranspose(Zq);

    Topl_lattice=interp3(X,Y,Z,Topl_index,Xq,Yq,Zq);
    Thick_lattice=interp3(X,Y,Z,Thick_index,Xq,Yq,Zq);
    Xq_lattice=interp3(X,Y,Z,X,Xq,Yq,Zq);
    Yq_lattice=interp3(X,Y,Z,Y,Xq,Yq,Zq);
    Zq_lattice=interp3(X,Y,Z,Z,Xq,Yq,Zq);


    Topl_lattice_1=(Topl_lattice(:,1:end-1,1:end-1)+Topl_lattice(:,2:end,2:end))/2;
    Xq_1=(Xq_lattice(:,1:end-1,1:end-1)+Xq_lattice(:,2:end,2:end))/2;
    Yq_1=(Yq_lattice(:,1:end-1,1:end-1)+Yq_lattice(:,2:end,2:end))/2;
    Zq_1=(Zq_lattice(:,1:end-1,1:end-1)+Zq_lattice(:,2:end,2:end))/2;

    Topl_lattice_2=(Topl_lattice(1:end-1,:,1:end-1)+Topl_lattice(2:end,:,2:end))/2;
    Xq_2=(Xq_lattice(1:end-1,:,1:end-1)+Xq_lattice(2:end,:,2:end))/2;
    Yq_2=(Yq_lattice(1:end-1,:,1:end-1)+Yq_lattice(2:end,:,2:end))/2;
    Zq_2=(Zq_lattice(1:end-1,:,1:end-1)+Zq_lattice(2:end,:,2:end))/2;

    Topl_lattice_3=(Topl_lattice(1:end-1,1:end-1,:)+Topl_lattice(2:end,2:end,:))/2;
    Xq_3=(Xq_lattice(1:end-1,1:end-1,:)+Xq_lattice(2:end,2:end,:))/2;
    Yq_3=(Yq_lattice(1:end-1,1:end-1,:)+Yq_lattice(2:end,2:end,:))/2;
    Zq_3=(Zq_lattice(1:end-1,1:end-1,:)+Zq_lattice(2:end,2:end,:))/2;

    Topl_lattice_0=(Topl_lattice(1:end-1,1:end-1,1:end-1)+Topl_lattice(2:end,2:end,2:end))/2;
    Xq_0=(Xq_lattice(1:end-1,1:end-1,1:end-1)+Xq_lattice(2:end,2:end,2:end))/2;
    Yq_0=(Yq_lattice(1:end-1,1:end-1,1:end-1)+Yq_lattice(2:end,2:end,2:end))/2;
    Zq_0=(Zq_lattice(1:end-1,1:end-1,1:end-1)+Zq_lattice(2:end,2:end,2:end))/2;

    figure(1)
    scatter3(Xq_lattice(:)*L_lattice(1)+Center_Body(1), ...
        Yq_lattice(:)*L_lattice(2)+Center_Body(2), ...
        Zq_lattice(:)*L_lattice(3)+Center_Body(3),20,Topl_lattice(:),'filled')
    hold on
    % for ii=1:N_cell(3)
    %     plot3(Xq_1(:,:,ii)*L_lattice(1),Yq_1(:,:,ii)*L_lattice(2),Zq_1(:,:,ii)*L_lattice(3),'k--')
    % end
    %
    % % scatter3(Xq_2(:)*L_lattice(1),Yq_2(:)*L_lattice(2),Zq_2(:)*L_lattice(3),[],Topl_lattice_2(:),'filled')
    %
    % for ii=1:N_cell(3)
    %     plot3(Xq_2(:,:,ii)'*L_lattice(1),Yq_2(:,:,ii)'*L_lattice(2),Zq_2(:,:,ii)'*L_lattice(3),'k--')
    % end
    % % scatter3(Xq_3(:)*L_lattice(1),Yq_3(:)*L_lattice(2),Zq_3(:)*L_lattice(3),[],Topl_lattice_3(:),'filled')
    %
    % plot3(reshape(Xq_3,[],N_cell(3)+1)'*L_lattice(1), ...
    %     reshape(Yq_3,[],N_cell(3)+1)'*L_lattice(2), ...
    %     reshape(Zq_3,[],N_cell(3)+1)'*L_lattice(3),'k--')
    colorbar
%   colormap copper

    axis equal
    xlabel('X')
    ylabel('Y')
    zlabel('Z')

    % figure(2)
    Truss_lattice=[];
    Point_lattice=[];
    Thick_point_lattice=[];
    Thick_truss_lattice=[];
    Topl_truss_lattice=[];
    Point_cell=[];
    Seq_cell=[];
    Truss_Offset_lattice=[];
    for ii=1:N_cell(1)
        for jj=1:N_cell(2)
            for kk=1:N_cell(3)
                Var=Topl_lattice([ii ii+1],[jj,jj+1],[kk,kk+1]);
                Var=Var(:);
                P_cell=[Xq_0(ii,jj,kk)*N_cell(1),Yq_0(ii,jj,kk)*N_cell(2),...
                    Zq_0(ii,jj,kk)*N_cell(3)]*L_cell;
                if Index_Offset==0
                    [Point_cell{ii,jj,kk}, Seq_cell{ii,jj,kk}]=BCC2TCubeGenerator_0(L_cell,Var,Drict_ANI(Index_ANI));
                elseif Index_Offset==1
                    [Point_cell{ii,jj,kk}, Seq_cell{ii,jj,kk}]=BCC2TCubeGenerator_1(L_cell,Var,Drict_ANI(Index_ANI));
                elseif Index_Offset==2
                    [Point_cell{ii,jj,kk}, Seq_cell{ii,jj,kk}]=BCC2TCubeGenerator_2(L_cell,Var,Drict_ANI(Index_ANI));
                elseif Index_Offset==3
                    [Point_cell{ii,jj,kk}, Seq_cell{ii,jj,kk}]=BCC2TCubeGenerator_3(L_cell,Var,Drict_ANI(Index_ANI));
                elseif Index_Offset==4
                    [Point_cell{ii,jj,kk}, Seq_cell{ii,jj,kk}]=BCC2TCubeGenerator_4(L_cell,Var,Drict_ANI(Index_ANI));                
                elseif Index_Offset==5
                    [Point_cell{ii,jj,kk}, Seq_cell{ii,jj,kk}]=BCC2TCubeGenerator_5(L_cell,Var,Drict_ANI(Index_ANI));
                elseif Index_Offset==6
                    [Point_cell{ii,jj,kk}, Seq_cell{ii,jj,kk}]=BCC2TCubeGenerator_6(L_cell,Var,Drict_ANI(Index_ANI));
                elseif Index_Offset==7
                    [Point_cell{ii,jj,kk}, Seq_cell{ii,jj,kk}]=BCC2TCubeGenerator_7(L_cell,Var,Drict_ANI(Index_ANI));
                elseif Index_Offset==8
                    [Point_cell{ii,jj,kk}, Seq_cell{ii,jj,kk}]=BCC2TCubeGenerator_8(L_cell,Var,Drict_ANI(Index_ANI));
                end
                % caculate the thickness value at the cell point
                Point_cell_lattice=P_cell'+Point_cell{ii,jj,kk};
                Thick_point_cell=interp3(X*L_lattice(1),Y*L_lattice(2),Z*L_lattice(3), ...
                    Thick_index,Point_cell_lattice(1,:),Point_cell_lattice(2,:),Point_cell_lattice(3,:));
                Topl_point_cell=interp3(X*L_lattice(1),Y*L_lattice(2),Z*L_lattice(3), ...
                Topl_index,Point_cell_lattice(1,:),Point_cell_lattice(2,:),Point_cell_lattice(3,:));
 

                
                Truss_cell_1=[];
                Truss_cell_2=[];
                Thick_truss_cell_1=[];
                Thick_truss_cell_2=[];
                % choose the selected beam for stacking
                Seq_cell_1=[];
                Seq_cell_2=[];
                Topl_truss_cell_1=[];
                Topl_truss_cell_2=[];

                Seq_cell_1=Seq_cell{ii,jj,kk}{1};
                for mm=1:size(Seq_cell_1,1)
                    Truss_cell_1(mm,:)=reshape(P_cell'+Point_cell{ii,jj,kk}(:,Seq_cell_1(mm,:)),1,[]);
                    Thick_truss_cell_1(mm,:)=Thick_point_cell(Seq_cell_1(mm,:));
                    Topl_truss_cell_1(mm,:)=Topl_point_cell(Seq_cell_1(mm,:));
                end



                Seq_cell_2=[Seq_cell{ii,jj,kk}{2}{1};Seq_cell{ii,jj,kk}{3}{1};Seq_cell{ii,jj,kk}{4}{1}];
                Seq_cell_2=[Seq_cell_2;Seq_cell{ii,jj,kk}{5}{1};Seq_cell{ii,jj,kk}{6}{1};Seq_cell{ii,jj,kk}{7}{1}];
                if Drict_ANI(Index_ANI)==1
                    Id_1=ii;  Id_2=jj; Id_3=kk; D_1=1; D_2=2; D_3=3;
                elseif Drict_ANI(Index_ANI)==2
                    Id_1=kk;  Id_2=ii; Id_3=jj; D_1=3; D_2=1; D_3=2;
                elseif Drict_ANI(Index_ANI)==3
                    Id_1=jj;  Id_2=kk; Id_3=ii; D_1=2; D_2=3; D_3=1;                 
                end

                %edge share
                if Id_1==N_cell(D_1)&Id_2==N_cell(D_2)
                    Seq_cell_2=[Seq_cell_2;Seq_cell{ii,jj,kk}{5}{2}];
                    Seq_cell_2=[Seq_cell_2;Seq_cell{ii,jj,kk}{5}{3}];
                    Seq_cell_2=[Seq_cell_2;Seq_cell{ii,jj,kk}{5}{4}];
                elseif Id_1==N_cell(D_1)
                    Seq_cell_2=[Seq_cell_2;Seq_cell{ii,jj,kk}{5}{2}];
                elseif Id_2==N_cell(D_2)
                    Seq_cell_2=[Seq_cell_2;Seq_cell{ii,jj,kk}{5}{3}];
                end
                %face share
                if Id_1==N_cell(D_1)
                    Seq_cell_2=[Seq_cell_2;Seq_cell{ii,jj,kk}{2}{2}];
                end
                if Id_2==N_cell(D_2)
                    Seq_cell_2=[Seq_cell_2;Seq_cell{ii,jj,kk}{3}{2}];
                end
                if Id_3==N_cell(D_3)
                    Seq_cell_2=[Seq_cell_2;Seq_cell{ii,jj,kk}{4}{2}];
                end
                  

                 

                for nn=1:size(Seq_cell_2,1)
                    Truss_cell_2(nn,:)=reshape(P_cell'+Point_cell{ii,jj,kk}(:,Seq_cell_2(nn,:)),1,[]);
                    Thick_truss_cell_2(nn,:)=Thick_point_cell(Seq_cell_2(nn,:));
                    Topl_truss_cell_2(nn,:)=Topl_point_cell(Seq_cell_2(nn,:));
                end

                Truss_lattice=[Truss_lattice;Truss_cell_1;Truss_cell_2];
                Point_lattice=[Point_lattice,P_cell'+Point_cell{ii,jj,kk}];
                Thick_point_lattice=[Thick_point_lattice,Thick_point_cell];
                Thick_truss_lattice=[Thick_truss_lattice;Thick_truss_cell_1;Thick_truss_cell_2];
                Topl_truss_lattice=[Topl_truss_lattice;Topl_truss_cell_1;Topl_truss_cell_2];


            end
        end
    end

    Point_Offset_lattice=[];
    Point_Offset_lattice(1,:)=interp3(X*L_lattice(1),Y*L_lattice(2),Z*L_lattice(3),Offset_X,Point_lattice(1,:),Point_lattice(2,:),Point_lattice(3,:));
    Point_Offset_lattice(2,:)=interp3(X*L_lattice(1),Y*L_lattice(2),Z*L_lattice(3),Offset_Y,Point_lattice(1,:),Point_lattice(2,:),Point_lattice(3,:));
    Point_Offset_lattice(3,:)=interp3(X*L_lattice(1),Y*L_lattice(2),Z*L_lattice(3),Offset_Z,Point_lattice(1,:),Point_lattice(2,:),Point_lattice(3,:));
    Point_lattice=Point_lattice+Point_Offset_lattice;
    Point_lattice=Point_lattice+Center_Body';

    
    Sign_point_1= Point_lattice(3,:)+Point_lattice(1,:)+Offset_J*L_cell ;
    Sign_point_2= Point_lattice(3,:)-Point_lattice(1,:)-Offset_J*L_cell  ;
    Sign_point_3= Point_lattice(3,:);% Z
    Sign_point_4= Point_lattice(1,:);% X
    Sign_point_5= Point_lattice(2,:);% Y<-- AJOUT : On récupère l'axe Y (ligne 2)
     
    if Index_ANI==1      
        Sign_1=( Sign_point_1 >(-0.5*L_cell-1e-2) )& ( Sign_point_2 <( 0.5*L_cell+1e-2) );  
        Sign_2=( Sign_point_1 <( 0.5*L_cell+1e-2) )& ( Sign_point_2 >(-0.5*L_cell-1e-2) );     
        Sign_3=( Sign_point_3 < 0.5*(N_H-1)*L_cell+1e-2)&(Sign_point_3 >-0.5*(N_H-1)*L_cell-1e-2);
        Sign_4=( Sign_point_4 > -w_L*L_cell-1e-2 )&(Sign_point_4 <w_R*L_cell+1e-2);
        
        % <-- AJOUT : Exemple pour rogner tout ce qui dépasse Y = 10 ou Y = -10
        %Sign_5=( Sign_point_5 > 0 );
        
        range_point=find( (Sign_1|Sign_2)&Sign_3&Sign_4)
     
    else    

        Sign_1= ( Sign_point_1 >(0*L_cell-1e-2) )& ( Sign_point_2 >(0*L_cell-1e-2) );  
        Sign_2= ( Sign_point_1 <(0*L_cell+1e-2) )& ( Sign_point_2 <(0*L_cell+1e-2) );          
        Sign_3= ( Sign_point_3 < 0*L_cell+1e-2)|(Sign_point_3 >0.5*L_cell-1e-2) ;

        % <-- AJOUT : Exemple pour rogner tout ce qui dépasse Y = 10 ou Y = -10
        %Sign_5=( Sign_point_5 > -5 ) & ( Sign_point_5 < 5 );
        Sign_4 = (Sign_point_4 < 0+1e-2);        
        Sign_5 = (Sign_point_5 < 0+1e-2);
        Sign_6 = (Sign_point_3 > -10-1e-2);
        
        range_point=find((Sign_1|Sign_2) & Sign_3 & Sign_4 & Sign_5 & Sign_6)

    end
% range_point2=range_point
% range_point=range_point2
%     load('Sec12_1.mat','range_point')
%     sum(abs(range_point2-range_point))
%     if Index_ANI==1
%         load('Sec12_1.mat')
%     elseif Index_ANI==2
%         load('Sec12_2.mat')
%     elseif Index_ANI==3
%         load('Sec12_3.mat')
%     end
    Point_lattice=Point_lattice(:,range_point);
    Thick_point_lattice=Thick_point_lattice(:,range_point);

     

    Truss_Offset_lattice(:,[1,4])=interp3(X*L_lattice(1),Y*L_lattice(2),Z*L_lattice(3),Offset_X,Truss_lattice(:,[1,4]),Truss_lattice(:,[2,5]),Truss_lattice(:,[3,6]));
    Truss_Offset_lattice(:,[2,5])=interp3(X*L_lattice(1),Y*L_lattice(2),Z*L_lattice(3),Offset_Y,Truss_lattice(:,[1,4]),Truss_lattice(:,[2,5]),Truss_lattice(:,[3,6]));
    Truss_Offset_lattice(:,[3,6])=interp3(X*L_lattice(1),Y*L_lattice(2),Z*L_lattice(3),Offset_Z,Truss_lattice(:,[1,4]),Truss_lattice(:,[2,5]),Truss_lattice(:,[3,6]));
    Truss_lattice=Truss_lattice+Truss_Offset_lattice;    
    Truss_lattice=Truss_lattice+[Center_Body,Center_Body];

   


    Sign_truss_1_1=  (Truss_lattice(:,3)+Truss_lattice(:,1)+Offset_J*L_cell);
    Sign_truss_1_2=  (Truss_lattice(:,3)-Truss_lattice(:,1)-Offset_J*L_cell);
    

    % <-- AJOUT : Axe Y de l'extrémité 1 (colonne 2)
    Sign_truss_1_3=  (Truss_lattice(:,3));% Z
    Sign_truss_1_4=  (Truss_lattice(:,1));% X
    Sign_truss_1_5=  (Truss_lattice(:,2));% Y

    Sign_truss_2_1=  (Truss_lattice(:,6)+Truss_lattice(:,4)+Offset_J*L_cell);
    Sign_truss_2_2=  (Truss_lattice(:,6)-Truss_lattice(:,4)-Offset_J*L_cell);
   

    % <-- AJOUT : Axe Y de l'extrémité 2 (colonne 5)
    Sign_truss_2_3=   (Truss_lattice(:,6));% Z
    Sign_truss_2_4=   (Truss_lattice(:,4));% X
    Sign_truss_2_5=   (Truss_lattice(:,5));% Y
    

    if Index_ANI==1        

        Sign_1 =  ( (Sign_truss_1_1>(-0.5*L_cell-1e-2)& Sign_truss_1_2<(0.5*L_cell+1e-2))  ...
            & (Sign_truss_2_1>(-0.5*L_cell-1e-2)& Sign_truss_2_2<(0.5*L_cell+1e-2)) )  ;
        Sign_2 =  ( (Sign_truss_1_1<(0.5*L_cell+1e-2)& Sign_truss_1_2>(-0.5*L_cell-1e-2))  ...
            & (Sign_truss_2_1<(0.5*L_cell+1e-2)& Sign_truss_2_2>(-0.5*L_cell-1e-2)) )  ;
        Sign_3 = (Sign_truss_1_3>-0.5*(N_H-1)*L_cell-1e-2)&(Sign_truss_2_3>-0.5*(N_H-1)*L_cell-1e-2)&...
                 (Sign_truss_1_3<0.5*(N_H-1)*L_cell+1e-2)&(Sign_truss_2_3<0.5*(N_H-1)*L_cell+1e-2) ;
        Sign_4 = (Sign_truss_1_4>-w_L*L_cell-1e-2)&(Sign_truss_2_4>-w_L*L_cell-1e-2)&...
                 (Sign_truss_1_4<w_R*L_cell+1e-2)&(Sign_truss_2_4<w_R*L_cell+1e-2) ;

        % <-- AJOUT : La même condition de coupe pour les deux extrémités du cylindre
        Sign_5 = (Sign_truss_1_5 > -5) & (Sign_truss_2_5 > -5) & (Sign_truss_1_5 < 5) & (Sign_truss_2_5 < 5);
        
        range_truss=find((Sign_1|Sign_2)&(Sign_3)&(Sign_4)); % &(Sign_5)

    else 
        Sign_1 =  ( (Sign_truss_1_1>(0*L_cell-1e-2)& Sign_truss_1_2>(0*L_cell-1e-2))  ...
            & (Sign_truss_2_1>(0*L_cell-1e-2)& Sign_truss_2_2>(0*L_cell-1e-2)) )  ;
        Sign_2 =  ( (Sign_truss_1_1<(0*L_cell+1e-2)& Sign_truss_1_2<(0*L_cell+1e-2))  ...
            & (Sign_truss_2_1<(0*L_cell+1e-2)& Sign_truss_2_2<(0*L_cell+1e-2)) )  ;
        Sign_3 = (Sign_truss_1_3>0.5*L_cell-1e-2)&(Sign_truss_2_3>0.5*L_cell-1e-2) ;
        Sign_4 = (Sign_truss_1_3<0*L_cell+1e-2)&(Sign_truss_2_3<0*L_cell+1e-2) ;
        % <-- AJOUT : La même condition de coupe pour les deux extrémités du cylindre

        Sign_5 = (Sign_truss_1_4 < 2.5+1e-2) & (Sign_truss_2_4 < 2.5+1e-2);        
        Sign_6 = (Sign_truss_1_3 > -15-1e-2) & (Sign_truss_2_3 > -15-1e-2);
        % Sign_7 = (Sign_truss_1_3 > -5) & (Sign_truss_2_4 > -5) & (Sign_truss_1_4 < 20) & (Sign_truss_2_4 < 20);
        
        range_truss=find((1|(Sign_1|Sign_2)&(Sign_3|Sign_4))&(Sign_5)&(Sign_6)); %range_truss=find(1|(Sign_1|Sign_2)&(Sign_3|Sign_4)); Tifff pour garder certains bouts
    end
 
%     if Index_ANI==1
%         load('Sec12_1.mat')
%     elseif Index_ANI==2
%         load('Sec12_2.mat')
%     elseif Index_ANI==3
%         load('Sec12_3.mat')
%     end
    Truss_lattice=Truss_lattice(range_truss,:);
    Thick_truss_lattice=Thick_truss_lattice(range_truss,:);
    Topl_truss_lattice=Topl_truss_lattice(range_truss,:);


%     if Index_ANI==1
%         save('Sec12_1.mat','range_point','range_truss')
%     elseif Index_ANI==2
%         save('Sec12_2.mat','range_point','range_truss')
%     elseif Index_ANI==3
%         save('Sec12_3.mat','range_point','range_truss')
%     end

    




    figure(2)
    hold on
%     scatter3(Point_lattice(1,:),Point_lattice(2,:),Point_lattice(3,:))
%     plot3(Truss_lattice(:,[1 4])',Truss_lattice(:,[2 5])',Truss_lattice(:,[3 6])','-','color',[0 0.45 0.64],'markersize',2)

Min_Z=min(Truss_lattice(:,[3 6]),[],'all')
Max_Z=max(Truss_lattice(:,[3 6]),[],'all')
figure(2)
hold on
for ii=1:size(Truss_lattice,1)
    %Draw_cylinder(Truss_lattice(ii,1:3),Truss_lattice(ii,4:6),Thick_truss_lattice(ii,1:2),Topl_truss_lattice(ii,1:2)')
    Draw_grad_lines(Truss_lattice(ii,1:3),Truss_lattice(ii,4:6), Topl_truss_lattice(ii,1:2)',2 )
    %Draw_grad_lines(Truss_lattice(ii,1:3),Truss_lattice(ii,4:6), 2*(Truss_lattice(ii,[3 6])'-Min_Z)/(Max_Z-Min_Z),2 )
end

axis equal
xlabel('X')
ylabel('Y')
zlabel('Z')
grid on

    axis equal
    xlabel('X')
    ylabel('Y')
    zlabel('Z')
   Truss_lattice_M=[Truss_lattice_M;Truss_lattice];
   Thick_truss_lattice_M=[Thick_truss_lattice_M;Thick_truss_lattice];
   Point_lattice_M=[Point_lattice_M,Point_lattice];
   Thick_point_lattice_M=[Thick_point_lattice_M,Thick_point_lattice];


view([0 -1 0])

 


   if Index_ANI==1 || Index_ANI==4
       %
       output_data_1=[(Truss_lattice_M(:,1:3)+Truss_lattice_M(:,4:6))/2,(Truss_lattice_M(:,4:6)-Truss_lattice_M(:,1:3))/2,Thick_truss_lattice_M];
       output_data_1(sum(abs(output_data_1(:,4:6)),2)<0.05,:)=[];

       % generate and write the geo text for modeling
       Position_truss=output_data_1(:,1:3)+[0 0 10];
       Vector_truss=output_data_1(:,4:6);
       length_truss=sqrt(sum(Vector_truss.^2,2));
       d_truss=output_data_1(:,7:8);
       angle_b_truss = acosd(Vector_truss(:,3)./length_truss);  % inclination angle
       angle_c_truss = atan2d(Vector_truss(:,2),Vector_truss(:,1));     %azimuthal angle

       output_data_2=[Point_lattice_M',Thick_point_lattice_M'];
       [C,ia,ic]=unique(output_data_2(:,1:3),"rows");
       output_data_2=output_data_2(ia,:);

       if  Index_ANI==1
           fileID = fopen(['C:\1-Tifaine\01_COURS_EPFL_01\2-Master\Projets semestre-master\Lattice Multi-DoF Gripper\Week_14\1Dof_Joint_SP_Lattice_2_config_bloc_3Height_3width_PLA.scad'],'w');
           Truss_lattice_M=[]
           Thick_truss_lattice_M=[]
           Point_lattice_M=[ ];
           Thick_point_lattice_M=[ ];
       elseif Index_ANI==4
           fileID = fopen(['C:\1-Tifaine\01_COURS_EPFL_01\2-Master\Projets semestre-master\Lattice Multi-DoF Gripper\Week_14\1Dof_Joint_SP_Lattice_1_config_bloc_3Height_3width_PLA.scad'],'w');
       end
       % fprintf(fileID,'intersection() {\n');
       % fprintf(fileID,'translate( v=[ 0, 0,  0]){cylinder(h= 10,d1=46,d2=38,center=true,$fn=6);};\n');
       fprintf(fileID,'union() {\n');
       % fprintf(fileID,'   translate( v=[ 30,  30,  5]){cube(size = [60, 60,0.5], center = true);};\n');
       fprintf(fileID,'   translate( v=[%8.5f, %8.5f, %8.5f]){rotate([0, %8.5f, %8.5f]){cylinder(h= %8.5f,d1= %8.5f,d2= %8.5f,center=true,$fn=12);};};\n',...
           [Position_truss,angle_b_truss,angle_c_truss,2*length_truss,d_truss]');


       % fprintf(fileID,'Sphere(%d) = {%8.5f, %8.5f, %8.5f, 0.375, -Pi/2, Pi/2, 2*Pi};\n',...
       %     [100+size(output_data_1,1)+(1:size(output_data_2,1))',output_data_2]');
       Position_sphere=output_data_2(:,1:3)+[0 0 10];
       d_sphere=output_data_2(:,4);
       fprintf(fileID,'   translate( v=[%8.5f, %8.5f, %8.5f]) {sphere(d= %8.5f,$fn=12);};\n',[Position_sphere, d_sphere]');
       fprintf(fileID,'};\n');
       % fprintf(fileID,'};\n');
       % fprintf(fileID,'Mesh.MeshSizeFromCurvature = 20;\n');
       % fprintf(fileID,'Mesh.MeshSizeMin = 0.01;\n');
       % fprintf(fileID,'Mesh.MeshSizeMax = 0.3;\n');
       % fprintf(fileID,'Coherence;\n');
       fclose(fileID);
   end

end









