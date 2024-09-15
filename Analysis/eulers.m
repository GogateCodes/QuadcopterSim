%% Plot axes and body reference frame

x =         1*[ 1  1  1  1  1; 
                  1  1 -1 -1  1;
                  1  1 -1 -1  1;
                  1  1  1  1  1 ];
y =         1*[ 1 -1 -1  1  1; 
                  1 -1 -1  1  1;
                  1 -1 -1  1  1;
                  1 -1 -1  1  1 ];
z =         0.1*[-1 -1 -1 -1 -1;
                 -1 -1 -1 -1 -1;
                  1  1  1  1  1;
                  1  1  1  1  1 ];
Ax_I_x = [1,0,0]';
Ax_I_y = [0,1,0]';
Ax_I_z = [0,0,1]';

Ax_I(:,:,1) = Ax_I_x;
Ax_I(:,:,2) = Ax_I_y;
Ax_I(:,:,3) = Ax_I_z;

Q_I(:,:,1) = x;
Q_I(:,:,2) = y;
Q_I(:,:,3) = z;

Yaw     = 20*pi/180;
Pitch   = 0*pi/180;
Roll    = 30*pi/180;

Q_R = RotZYXB2I(Q_I, Yaw, Pitch, Roll);
Ax_R = RotZYXB2I(Ax_I, -Yaw, -Pitch, -Roll);
 

fig = figure(1);clf;hold on;
surf(Q_I(:,:,1),Q_I(:,:,2),Q_I(:,:,3),'FaceColor',[0    0.2    0.5],'FaceAlpha',0.4)


surf(Q_R(:,:,1),Q_R(:,:,2),Q_R(:,:,3),'FaceColor',[0.5    0    0.2],'FaceAlpha',0.4)

quiver3(0,0,0,Ax_I(1,1,1),Ax_I(1,2,1),Ax_I(1,3,1),"Color",[0.6350 0.0780 0.1840],"LineWidth",2)
quiver3(0,0,0,Ax_I(1,1,2),Ax_I(1,2,2),Ax_I(1,3,2),"Color",[0.4660 0.6740 0.1880],"LineWidth",2)
quiver3(0,0,0,Ax_I(1,1,3),Ax_I(1,2,3),Ax_I(1,3,3),"Color",[0.0000 0.4470 0.7410],"LineWidth",2)

quiver3(0,0,0,Ax_R(1,1,1),Ax_R(1,2,1),Ax_R(1,3,1),"Color",[0.6350 0.0780 0.1840],"LineWidth",2,"LineStyle",'--')
quiver3(0,0,0,Ax_R(1,1,2),Ax_R(1,2,2),Ax_R(1,3,2),"Color",[0.4660 0.6740 0.1880],"LineWidth",2,"LineStyle",'--')
quiver3(0,0,0,Ax_R(1,1,3),Ax_R(1,2,3),Ax_R(1,3,3),"Color",[0.0000 0.4470 0.7410],"LineWidth",2,"LineStyle",'--')
set(fig.CurrentAxes,"XLim",[-1.5 1.5],"YLim",[-1.5 1.5],"ZLim",[-1.5 1.5]);
xlabel("x")
ylabel("y")
zlabel("z")
grid on

function [Vout] = RotZYXB2I(V, Yaw, Pitch, Roll)
    Vout = zeros(size(V));
    for i = 1:size(V,1)
        for j = 1:size(V,2)
            tmp = squeeze(V(i,j,:));
            tmp = RotXB2I(Roll) * RotYB2I(Pitch) * RotZB2I(Yaw) * tmp;

            Vout(i,j,:) = reshape(tmp,[1,1,3]);
        end
    end
end

function [Vout] = RotZYXI2B(V, Yaw, Pitch, Roll)
    Vout = zeros(size(V));
    for i = 1:size(V,1)
        for j = 1:size(V,2)
            tmp = squeeze(V(i,j,:));
            tmp =  RotZB2I(Yaw) * RotYB2I(Pitch) * RotXB2I(Roll) * tmp;
           
            Vout(i,j,:) = reshape(tmp,[1,1,3]);
        end
    end
end

function [mat] = RotZI2B(t)
% I to B
    mat = [cos(t), sin(t), 0;...
        -sin(t), cos(t), 0;...
        0,0,1];
end

function [mat] = RotYI2B(t)
% I to B
    mat = [cos(t),0, -sin(t);...
        0,1,0;...
        sin(t), 0, cos(t)];
end

function [mat] = RotXI2B(t)
% I to B
    mat = [1,0,0;...
        0,cos(t), sin(t);...
        0,-sin(t), cos(t)];
end

function [mat] = RotZB2I(t)
% I to B
    mat = [cos(t), -sin(t), 0;...
        sin(t), cos(t), 0;...
        0,0,1];
end

function [mat] = RotYB2I(t)
% I to B
    mat = [cos(t),0, sin(t);...
        0,1,0;...
        -sin(t), 0, cos(t)];
end

function [mat] = RotXB2I(t)
% I to B
    mat = [1,0,0;...
        0,cos(t), -sin(t);...
        0,sin(t), cos(t)];
end