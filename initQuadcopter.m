CNFG_FSTEP = 300000;
CNFG_TSTEP = 1.0/CNFG_FSTEP;
CNFG_TEND = 2;

CNST.g =9.81;

CNTR.FSTEP = 200;
CNTR.TSTEP = 1.0/CNTR.FSTEP;

% Motor Parametersgit st
MOTR.RL = 0.1;
MOTR.LL = 0.03e-3;
MOTR.RP = MOTR.RL/2;
MOTR.LD = MOTR.LL/2;
MOTR.LQ = MOTR.LL/2;
MOTR.NP = 6;
MOTR.NPP = MOTR.NP/2;
MOTR.KB = 0.05*2/3;
MOTR.KT = MOTR.KB;
MOTR.J = 0.58e-6;
MOTR.B = 0.43e-6;
MOTR.D = 0;

% Propeller Parameters
PROP.L = 5.5;
PROP.Pitch = 50;
PROP.CL = 9.81/1000; % 10000 PRM ~ 1000 rad/s -> 1000g Thrust  ~ 9.81 Nm  
PROP.CD = 0.8*PROP.CL;

% Quadcopter Parameters
QUAD.Length = 7*0.0254;
QUAD.Height = 2*0.0254;
QUAD.Width = 0;
QUAD.MomemtArm = sqrt(QUAD.Length^2 + QUAD.Width)/2;
QUAD.Mass = 1; % Kg
QUAD.Ixx = 0.014;
QUAD.Iyy = 0.014;
QUAD.Izz = 0.022;
QUAD.J = [  QUAD.Ixx,   0,          0; 
            0,          QUAD.Iyy,   0; 
            0,          0,          QUAD.Izz  ];
QUAD.Jinv = inv(QUAD.J);
QUAD.AeroRotDrag = [0.5e-4,0.5e-4,0.1e-4]/10;

QUAD.YawMap = [1,-1,1,-1];
QUAD.PitchMap = [1,1,-1,-1];
QUAD.RollMap = [-1,1,1,-1];

QUAD.VelMap = [1,1,1,1];

QUAD.RollIC = 0.1;
QUAD.PitchIC =0.0;
Quad.YawIC = 0.0;

BATT.V = 11.1;

SNSR.GYRO.Name = "MPU6050";
SNSR.GYRO.Noise = 0.05^2; % Variance

CNTR.PZ.Kp = 1;

