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

Yaw =  20*pi/180; % About Z Axis
Pitch = -10*pi/180; % About Y Axis
Roll =  -30*pi/180; % About X Axis

Q_I2 = reshape(Q_I,[20,3]);
Q_R2 = fnRotVec(Q_I2, Yaw, Pitch, Roll, 'ZYX');
Q_R = reshape(Q_R2,[4,5,3]);

Ax_R = fnRotVec(Ax_I, Yaw, Pitch, Roll, 'ZYX');

figure(1);clf;hold on;
title("Inertial Frame")
surf(Q_I(:,:,1),Q_I(:,:,2),Q_I(:,:,3),'FaceColor',[0    0.2    0.5],'FaceAlpha',0.4)
surf(Q_R(:,:,1),Q_R(:,:,2),Q_R(:,:,3),'FaceColor',[0.5    0    0.2],'FaceAlpha',0.4)

plotAxes(Ax_I,1.5,1,'-')
plotAxes(Ax_R,1.5,1,':')
plotGrav(G_I,1)
view(-45,30)

xlim([-1.5 1.5])
ylim([-1.5 1.5])
zlim([-1.5 1.5])
xlabel("x")
ylabel("y")
zlabel("z")
grid on

Q_R2 = reshape(Q_R,[20,3]);
Q_B2 = fnRotVecInv(Q_R2, Yaw, Pitch, Roll, 'ZYX');
Q_B = reshape(Q_B2,[4,5,3]);

Ax_B = fnRotVecInv(Ax_R, Yaw, Pitch, Roll, 'ZYX');

G_B = fnRotVecInv(G_I, Yaw, Pitch, Roll, 'ZYX');

figure(2);clf;hold on;
title("Body Frame")
surf(Q_B(:,:,1),Q_B(:,:,2),Q_B(:,:,3),'FaceColor',[0.5    0    0.2],'FaceAlpha',0.4)

plotAxes(Ax_B,1.5,2,':')
plotGrav(G_B,2)
view(-45,30)
xlim([-1.5 1.5])
ylim([-1.5 1.5])
zlim([-1.5 1.5])
xlabel("x")
ylabel("y")
zlabel("z")
grid on

Pitch_Est = atan2(G_B(1),(G_B(2)^2 + G_B(3)^2)^0.5)*180/pi
Roll_Est = atan2(-G_B(2),-G_B(3))*180/pi

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
