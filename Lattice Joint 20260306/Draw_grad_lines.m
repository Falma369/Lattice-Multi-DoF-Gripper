function Draw_grad_lines(point1, point2,Color,Line_Width)

% Color [c11,c12, c13;c21,c22, c23] or [ref1; ref2]
% point1=[0 0 0]
% point2=[10 10 10]
% Color=[0;2]

% interplot the lines and colors
 
t=linspace(0, 1, 2)';
Points_plot=(1-t)*point1+ t*point2;
if size(Color,1)==1% single color beam
    if size(Color,2)==3
        plot3(Points_plot(1:end,1),Points_plot(2:end,2),Points_plot(3:end,3),'-','Color',Color,'LineWidth',Line_Width)
    elseif size(Color,2)==1
        ref_points = linspace(0.2,0.8,101); % 参考点的 x 位置
        ref_colors = pink(length(ref_points)); % 使用 jet 颜色映射
        ref_colors =flip(ref_colors,1);
        Color_3(:,1)=interp1(ref_points,ref_colors(:,1),Color/2);
        Color_3(:,2)=interp1(ref_points,ref_colors(:,2),Color/2);
        Color_3(:,3)=interp1(ref_points,ref_colors(:,3),Color/2);
        plot3(Points_plot(1:end,1),Points_plot(1:end,2),Points_plot(1:end,3),'-','Color',Color_3,'LineWidth',Line_Width)
    end
elseif size(Color,1)==2% gradient color beam
    if size(Color,2)==3
        t_2=(t(1:end-1)+t(2:end))/2;
        Color_M= (1-t_2)*Color(1,:)+t_2*Color(2,:);
        for ii=1: (length(t)-1)
            plot3(Points_plot([ii ii+1],1),Points_plot([ii ii+1],2),Points_plot([ii ii+1],3),'-','Color',Color_M(ii,:),'LineWidth',Line_Width)
        end
    elseif size(Color,2)==1
        t_2=(t(1:end-1)+t(2:end))/2;
        Color_v=(1-t_2)*Color(1)+t_2*Color(2);
        % matlab color
        ref_points = linspace(0,1,46).^2 ; % 参考点的 x 位置
        ref_colors = pink(101); % 使用 jet 颜色映射
%         ref_colors = autumn(101); % 使用 jet 颜色映射
%         ref_colors = spring(101); % 使用 jet 颜色映射
        ref_colors =ref_colors(50:-1:5,:);
%         ref_colors =ref_colors(70:-1:40,:);
%         ref_colors =ref_colors(40:1:70,:);
        
        % self defined color
        ref_points=linspace(1,-0.4,5).^2.*sign(linspace(1,-0.4,5));
        ref_colors=[76 46 89;
                    152 86 136;
                     217 134 165;
                     247 188 190;
                     252 234 230]/255;        
        Color_M(:,1)=interp1(ref_points,ref_colors(:,1),Color_v/2);
        Color_M(:,2)=interp1(ref_points,ref_colors(:,2),Color_v/2);
        Color_M(:,3)=interp1(ref_points,ref_colors(:,3),Color_v/2);
        for ii=1: (length(t)-1)
            hold on
            plot3(Points_plot([ii ii+1],1),Points_plot([ii ii+1],2),Points_plot([ii ii+1],3),'-','Color',Color_M(ii,:),'LineWidth',Line_Width)
            hold off
        end
    end
end


 
end





