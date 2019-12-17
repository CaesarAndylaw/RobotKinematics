%% Robot Property
% note: Please keep the parameter constant
function robot=robotproperty_detail(id)
robot.name = id;
switch id    
        case 'GP50'
        %the constants
        robot.nlink=6; % robot links
        robot.umax=10; % max acceleration
        robot.delta_t=0.5; % the sample time

        robot.DH=[0, 0.281, 0.145, -pi/2; % the DH parameter
                  -pi/2, 0, 0.87, 0;
                  0, 0, 0.21, -pi/2;
                  0, 1.025, 0, pi/2;
                  0, 0, 0, -pi/2;
                  0, 0.675, 0, 0];%theta,d,a,alpha
              
        robot.dfDH=[0, 0.281, 0.145, -pi/2; % the DH parameter
                  -pi/2, 0, 0.87, 0;
                  0, 0, 0.21, -pi/2;
                  0, 1.025, 0, pi/2;
                  0, 0, 0, -pi/2;
                  0, 0.675, 0, 0];%theta,d,a,alpha    
           
        robot.base=[0;0;0.259]; % base link offset
        
        robot.cap={};
        % robot capsule for each link. 
        % Current capsule is not specified. 
        % End-effector measured offset, with respect to last coorfinate
        robot.cap{1}.p = [-0.145 -0.145;0.105 0.105;0 0];
        robot.cap{1}.r = 0.385;
        
        robot.cap{2}.p = [-0.87 0;0 0;-0.1945 -0.1945];
        robot.cap{2}.r = 0.195;
%         robot.cap{2}.r = 0.01;
        
        robot.cap{3}.p = [-0.02 -0.09;0.073 0.073;0.115 0.115];
        robot.cap{3}.r = 0.36;
%         robot.cap{3}.r = 0.01;
        
        robot.cap{4}.p = [0 0;-0.65 0;-0.0235 -0.0235];
        robot.cap{4}.r = 0.115;
%         robot.cap{4}.r = 0.01;
        
        robot.cap{5}.p = [0 0;0.0145 0.0145;0.025 0.025];
        robot.cap{5}.r = 0.15;
%         robot.cap{5}.r = 0.01;
        
        robot.cap{6}.p = [0 0;0 0;-0.465 -0.035];
        robot.cap{6}.r = 0.035;
%         robot.cap{5}.p=[0 0;0 0;0 0];
end

% the kinematic matrices
robot.A=[eye(robot.nlink) robot.delta_t*eye(robot.nlink);
        zeros(robot.nlink) eye(robot.nlink)];
robot.B=[0.5*robot.delta_t^2*eye(robot.nlink);
        robot.delta_t*eye(robot.nlink)];
robot.Ac=[eye(3) robot.delta_t*eye(3);
        zeros(3) eye(3)];
robot.Bc=[0.5*robot.delta_t^2*eye(3);
        robot.delta_t*eye(3)];

% the movement property 
robot.x(1:robot.nlink*2,1)=[robot.DH(:,1);zeros(robot.nlink,1)];%(theta1,theta2,theta,3,theta1dot,theta2dot,theta3dot)
robot.pos=CapPos_origin(robot.base,robot.DH,robot.cap);
robot.wx(1:3,1)=robot.pos{robot.nlink}.p(:,2); % end-effector Cartesian position
robot.wx(4:6,1)=[0;0;0]; % end-effector Cartesian acceleration
robot.mx=robot.wx; % closest point state

end