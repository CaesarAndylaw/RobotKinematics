% test draw cylinder 
function [X,Y,Z] = capsule_generate(R, cap1, cap2)
%     R = 0.17;


% %     cap1 = [-0.87,0,-0.1945];
% %     cap2 = [0,0,-0.1945];
%     cap1 = [0,-0.65,-0.0235];
%     cap2 = [0,0,-0.0235];
    points = 20;
    for i = 1:3
        if cap1(i) ~= cap2(2)
            break;
        end
    end
    switch i
        case 1
            direction = 'x';
        case 2
            direction = 'y';
        case 3 
            direction = 'z';
    end




    [X,Y,Z] = sphere(points);
    X = R*X;
    Y = R*Y;
    Z = R*Z;
    xm = X(11,:);
    ym = Y(11,:);
    zm = Z(11,:);


    % lower 
    X1 = X(1:11,:);
    Y1 = Y(1:11,:);
    Z1 = Z(1:11,:);

    % higher
    X2 = X(11:21,:);
    Y2 = Y(11:21,:);
    Z2 = Z(11:21,:);

    switch direction
        case 'x'
            disp('capsule along x axis');
            CHG = X1;
            X1 = Z1;
            Z1 = CHG; 

            CHG = X2;
            X2 = Z2;
            Z2 = CHG; 

            CHG = xm;
            xm = zm;
            zm = CHG; 
        case 'y'
            disp('capsule along y axis');
            CHG = Y1;
            Y1 = Z1;
            Z1 = CHG; 

            CHG = Y2;
            Y2 = Z2;
            Z2 = CHG; 

            CHG = ym;
            ym = zm;
            zm = CHG; 
        case 'z'
            disp('capsule along z axis');
    end
    X1 = X1 + cap1(1);
    xm = xm + cap1(1);
    Y1 = Y1 + cap1(2);
    ym = ym + cap1(2);
    Z1 = Z1 + cap1(3);
    zm = zm + cap1(3);

    X2 = X2 + cap2(1);
    Y2 = Y2 + cap2(2);
    Z2 = Z2 + cap2(3);



    % media
    XM = [];
    YM = [];
    ZM = [];
    diff = cap2 - cap1;
    for ratio = 0:0.1:1
        incre = ratio*diff;
        XM = [XM; xm+incre(1)];
        YM = [YM; ym+incre(2)];
        ZM = [ZM; zm+incre(3)];
    end

    % concatenate capsule 
    X = [X1;XM;X2];
    Y = [Y1;YM;Y2];
    Z = [Z1;ZM;Z2];
    
%     surf(X1,Y1,Z1);
%     hold on
%     
%     surf(X2,Y2,Z2);
%     hold on
%     
%     surf(XM,YM,ZM);
%     hold on
    
%     surf(X,Y,Z);
    
%     axis equal
%     
%     xlabel('x axis');
%     ylabel('y axis');
%     zlabel('z axis');
end