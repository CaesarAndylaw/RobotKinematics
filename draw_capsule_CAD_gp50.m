clear
robot=robotproperty('GP50');
% modify the DH parameters 
modify = [0;0;-pi/4;0;pi/2;0];
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
    color=[240,246,245]/400;
    for j=1:size(v,1) 
        v(j,:) = v(j,:) + [1.2,0,0];
    end
    handle.workpiece(i) = patch('Faces',f,'Vertices',v,'FaceVertexCData',c,'FaceColor',color,'EdgeColor','None');
end


% base
for i=1:numel(robotCAD.base)
    f=robotCAD.base{i}.f; v=robotCAD.base{i}.v.*scale; c=robotCAD.base{i}.c; color=robotCAD.base{i}.color;
    for j=1:size(v,1) 
        v(j,:) = v(j,:);
    end
    v = setVertice(v,M{1});
    handle.base(i) = patch('Faces',f,'Vertices',v,'FaceVertexCData',c,'FaceColor',color,'EdgeColor','None');
end
% Link
for i=1:5%length(robotCAD.link)
    v=robotCAD.link{i}.v.*scale; f=robotCAD.link{i}.f; c=robotCAD.link{i}.c; 
%     color=robotCAD.link{i}.color;
    color=[249,212,35]/255;
    v = setVertice(v,M{i+1});
%     v = FK(v,M{i+1}); 
%     v = v';
    handle.link(i) = patch('Faces',f,'Vertices',v,'FaceVertexCData',c,'FaceColor',color,'EdgeColor','None');
end


%% draw capsule 
valpha = 0.5;
color = [255,255,243]/255;
load(strcat('figure/', robot.name, 'Capsules.mat'));
boundary = RoBoundary;
handle=[];
n=min([size(M,2), length(boundary)]);
for i=1:n
    if isfield(boundary{i}, "X")
        X=boundary{i}.X;
        Y=boundary{i}.Y;
        Z=boundary{i}.Z;
        kd=size(X,1);jd=size(X,2);
        for k=1:kd
            for j=1:jd
                newvec=[X(k,j),Y(k,j),Z(k,j)]*M{i+1}(1:3,1:3)'+M{i+1}(1:3,4)';
                X(k,j)=newvec(1);
                Y(k,j)=newvec(2);
                Z(k,j)=newvec(3);
            end
        end
        handle(i)=surf(X,Y,Z,'FaceColor',color,'EdgeColor','None');
%         handle(i)=surf(X,Y,Z);
        alpha(handle(i),valpha);
    end
end



%% draw workpiece 
hold on
valpha = 0.8;
color = [255,255,243]/255;
planes = [-0.8553854681017643, -0.0005463239779652795, -1, 2.9257986256071304;
          0.05748143290163125, -1, 0.06252308341911939, -0.3026991195122747;
          -0.7329844887892633, 0.017746299409831523, -1, 2.462147522592861;
          -0.10475571509951867, -1, -0.13116945145812048, 0.49306524145584574];

for i = 1:size(planes,1)
    if planes(i,3) == -1
        x1 = 1.2:0.1:2.3;
        y1 = -0.205:0.05:0.205;
        [x, y] = meshgrid(x1,y1);
        z = planes(i,1)*x + planes(i,2)*y + planes(i,4);
    end
    if planes(i,2) == -1
        x1 = 1.2:0.1:2.3;
        z1 = 0.8:0.02:1.8;
        [x, z] = meshgrid(x1,z1);
        y = planes(i,1)*x + planes(i,3)*z + planes(i,4);
    end   
%     surf(x,y,z);
    handles(i)=surf(x,y,z,'FaceColor',color,'EdgeColor','None');
    alpha(handles(i),valpha);
    hold on 
end

xlim=[-1,2.5];
ylim=[-0.5,0.5];
zlim=[0,2.5];
view([1,-0.5,0.4]);
axis equal
axis([xlim,ylim,zlim]);
lighting=camlight('left');
%lighting phong
set(gca,'Color',[0.8 0.8 0.8]);
wall{1}.handle=fill3([xlim(1),xlim(1),xlim(2),xlim(2)],[ylim(1),ylim(2),ylim(2),ylim(1)],[zlim(1),zlim(1),zlim(1),zlim(1)],[63,64,64]/255);
wall{2}.handle=fill3([xlim(1),xlim(1),xlim(1),xlim(1)],[ylim(1),ylim(1),ylim(2),ylim(2)],[zlim(1),zlim(2),zlim(2),zlim(1)],[63,64,64]/255);
% wall{3}.handle=fill3([xlim(1),xlim(1),xlim(2),xlim(2)],[ylim(2),ylim(2),ylim(2),ylim(2)],[zlim(1),zlim(2),zlim(2),zlim(1)],[63,64,64]/255);
zlabel('z axis');
ylabel('y axis');
xlabel('x axis');
