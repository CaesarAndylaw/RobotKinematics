clear
robot=robotproperty('GP50');
% modify the DH parameters 
modify = [0;-pi/4;pi/4;0;pi/4;0];
robot.DH(:,1) = robot.DH(:,1) + modify;
M=CapPos(robot);
clf; hold on;
robotCAD = load(strcat('figure/',robot.name,'.mat'));
switch robot.name
    case 'M16iB'
        scale = 1/1000;
    case 'LRMate200iD7L'
        scale = 1/1000;
    otherwise
        scale = 1;
end

% workpiece
for i=1:numel(robotCAD.workpiece)
    f=robotCAD.workpiece{i}.f; v=robotCAD.workpiece{i}.v.*scale; c=robotCAD.workpiece{i}.c; 
    color=[240,246,245]/255;
    for j=1:size(v,1) 
        v(j,:) = v(j,:) + [1.2,0,0];
    end
    handle.workpiece(i) = patch('Faces',f,'Vertices',v,'FaceVertexCData',c,'FaceColor',color,'EdgeColor','None');
end

% xlim=[-1,4];
% ylim=[-1,1];
% zlim=[0,2];
view([1,-0.5,0.4]);
axis equal
axis([xlim,ylim,zlim]);
lighting=camlight('left');
%lighting phong
set(gca,'Color',[0.8 0.8 0.8]);
% wall{1}.handle=fill3([xlim(1),xlim(1),xlim(2),xlim(2)],[ylim(1),ylim(2),ylim(2),ylim(1)],[zlim(1),zlim(1),zlim(1),zlim(1)],[63,64,64]/255);
% wall{2}.handle=fill3([xlim(1),xlim(1),xlim(1),xlim(1)],[ylim(1),ylim(1),ylim(2),ylim(2)],[zlim(1),zlim(2),zlim(2),zlim(1)],[63,64,64]/255);
% wall{3}.handle=fill3([xlim(1),xlim(1),xlim(2),xlim(2)],[ylim(2),ylim(2),ylim(2),ylim(2)],[zlim(1),zlim(2),zlim(2),zlim(1)],[63,64,64]/255);
zlabel('z axis');
ylabel('y axis');
xlabel('x axis');