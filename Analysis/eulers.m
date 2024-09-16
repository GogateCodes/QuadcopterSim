%% Plot axes and body reference frame

% Body Surf Vertices x,y,z
vertex_x =         1*[ 1  1  1  1  1; 
                  1  1 -1 -1  1;
                  1  1 -1 -1  1;
                  1  1  1  1  1 ];
vertex_y =         0.7*[ 1 -1 -1  1  1; 
                  1 -1 -1  1  1;
                  1 -1 -1  1  1;
                  1 -1 -1  1  1 ];
vertex_z =         0.1*[-1 -1 -1 -1 -1;
                 -1 -1 -1 -1 -1;
                  1  1  1  1  1;
                  1  1  1  1  1 ];
Q_I(:,:,1) = vertex_x;
Q_I(:,:,2) = vertex_y;
Q_I(:,:,3) = vertex_z;

% Body Axes
Ax_I_x = [1,0,0];
Ax_I_y = [0,1,0];
Ax_I_z = [0,0,1];

Ax_I(1,:) = Ax_I_x;
Ax_I(2,:) = Ax_I_y;
Ax_I(3,:) = Ax_I_z;

G_I = [0,0,-1];

%%

Yaw     = 0*pi/180; % About Z Axis
Pitch   = 130*pi/180; % About Y Axis
Roll    = 130*pi/180; % About X Axis

Q_I2 = reshape(Q_I,[20,3]);
Q_R2 = RotateVector(Q_I2, Yaw, Pitch, Roll, 'ZYX');
Q_R = reshape(Q_R2,[4,5,3]);

Ax_R = RotateVector(Ax_I, Yaw, Pitch, Roll, 'ZYX');

g_R = RotateVector(g_vec, Yaw, Pitch, Roll, 'ZYX');

figure(1);clf;hold on;

surf(Q_I(:,:,1),Q_I(:,:,2),Q_I(:,:,3),'FaceColor',[0    0.2    0.5],'FaceAlpha',0.4)
surf(Q_R(:,:,1),Q_R(:,:,2),Q_R(:,:,3),'FaceColor',[0.5    0    0.2],'FaceAlpha',0.4)

plotAxes(Ax_I,1.5,1,'-')
plotAxes(Ax_R,1.5,1,':')
plotGrav(G_I,1)
view(-45,30)

% set(fig.CurrentAxes,"XLim",[-1.5 1.5],"YLim",[-1.5 1.5],"ZLim",[-1.5 1.5]);
xlim([-1.5 1.5])
ylim([-1.5 1.5])
zlim([-1.5 1.5])
xlabel("x")
ylabel("y")
zlabel("z")
grid on

% Q_B2 = reshape(Q_R,[20,3]);
% Q_R2 = RotateVector(Q_I2, Yaw, Pitch, Roll, 'ZYX');
% Q_R = reshape(Q_R2,[4,5,3]);

Ax_B = RotateVectorT(Ax_R, Yaw, Pitch, Roll, 'ZYX');

G_B = RotateVectorT(G_I, Yaw, Pitch, Roll, 'ZYX');

figure(2);clf;hold on;
plotAxes(Ax_B,1.5,2,':')
plotGrav(G_B,2)
view(-45,30)
%%
function plotAxes(V,scale,fig,props)
    figure(fig)
    Vx = V(1,:)*scale;
    Vy = V(2,:)*scale;
    Vz = V(3,:)*scale;
    quiver3(0,0,0,Vx(1),Vx(2),Vx(3),"Color",[0.6350 0.0780 0.1840],"LineWidth",2,"LineStyle",props)
    quiver3(0,0,0,Vy(1),Vy(2),Vy(3),"Color",[0.4660 0.6740 0.1880],"LineWidth",2,"LineStyle",props)
    quiver3(0,0,0,Vz(1),Vz(2),Vz(3),"Color",[0.0000 0.4470 0.7410],"LineWidth",2,"LineStyle",props)
end

function plotGrav(V,fig)
    figure(fig)
    Vx = V(1,:);
    quiver3(0,0,0,Vx(1),Vx(2),Vx(3),"Color",'k',"LineWidth",2)

end

function [Vout] = RotateVector(V, Yaw, Pitch, Roll, Method)
    if strcmp(Method,'ZYX')
        Vout = zeros(size(V));
        for i = 1:size(V,1)
                tmp = V(i,:)';
                tmp = RotZB2I(Yaw) * RotYB2I(Pitch) * RotXB2I(Roll) * tmp;
                Vout(i,:) = tmp';
        end
    elseif strcmp(Method,'XYZ')
        Vout = zeros(size(V));
        for i = 1:size(V,1)
                tmp = V(i,:)';
                tmp = RotXB2I(Roll) * RotYB2I(Pitch) * RotZB2I(Yaw) * tmp;
                Vout(i,:) = tmp';
        end
    else
        error("Method argument invalid. Select from: ['ZYX', 'XYZ']")
    end
    
end

function [Vout] = RotateVectorT(V, Yaw, Pitch, Roll, Method)
    if strcmp(Method,'ZYX')
        Vout = zeros(size(V));
        for i = 1:size(V,1)
                tmp = V(i,:)';
                tmp = (RotZB2I(Yaw) * RotYB2I(Pitch) * RotXB2I(Roll))' * tmp;
                Vout(i,:) = tmp';
        end
    elseif strcmp(Method,'XYZ')
        Vout = zeros(size(V));
        for i = 1:size(V,1)
                tmp = V(i,:)';
                tmp = (RotXB2I(Roll) * RotYB2I(Pitch) * RotZB2I(Yaw))' * tmp;
                Vout(i,:) = tmp';
        end
    else
        error("Method argument invalid. Select from: ['ZYX', 'XYZ']")
    end
    
end

% function [mat] = RotZI2B(t)
% % I to B
%     mat = [cos(t), sin(t), 0;...
%         -sin(t), cos(t), 0;...
%         0,0,1];
% end
% 
% function [mat] = RotYI2B(t)
% % I to B
%     mat = [cos(t),0, -sin(t);...
%         0,1,0;...
%         sin(t), 0, cos(t)];
% end
% 
% function [mat] = RotXI2B(t)
% % I to B
%     mat = [1,0,0;...
%         0,cos(t), sin(t);...
%         0,-sin(t), cos(t)];
% end

function [mat] = RotZB2I(t)
% I to B
    mat = [ cos(t), -sin(t), 0;...
            sin(t),  cos(t), 0;...
            0,       0,      1];
end

function [mat] = RotYB2I(t)
% I to B
    mat = [  cos(t),    0,  sin(t);...
             0,         1,  0;...
            -sin(t),    0,  cos(t)];
end

function [mat] = RotXB2I(t)
% I to B
    mat = [1,0,0;...
        0,cos(t), -sin(t);...
        0,sin(t), cos(t)];
end