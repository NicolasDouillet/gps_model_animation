function [] = gps_model_animation()
% gps_model_animation : function to create an animated model of the GPS
% showing its constellation and working principle.
%
% Author : nicolas.douillet9 (at) gmail.com, 2007-2024.


theta = linspace(0,pi,36)'; % latitude angle vector
phi = linspace(0,2*pi,72);  % longitude angle vector
r = 6.4; % Earth radius (in thousands Km)

% Rotation matrices
Mr1 = @(gamma)[1 0 0
               0 cos(gamma) sin(gamma)
               0 -sin(gamma) cos(gamma)];

Mr2 = @(alpha)[cos(alpha) sin(alpha) 0
               -sin(alpha) cos(alpha) 0
               0 0 1];

delta = linspace(0,2*pi,360);

% Computational parameters
R = 20;
a = 90;
b = 180;
f = 270;

one_loop = 360; % 2*pi rad in degres
sin_quater_pi = 0.5*sqrt(2);

rlim = R; % R*cos(asin((R-r)/R));


u = r*sin(theta)*cos(phi);
v = r*sin(theta)*sin(phi);
w = repmat(r*cos(theta),[1 length(phi)]);
c = rand(length(theta),length(phi));

S1 = Mr1(pi/3)*[R*cos(delta); R*sin(delta); zeros(1,length(delta))];
S2 = Mr2(pi/3)*S1;
S3 = Mr2(pi/3)*S2;
S4 = Mr2(pi/3)*S3;
S5 = Mr2(pi/3)*S4;
S6 = Mr2(pi/3)*S5;

% Display parameters
marker_size = 40;
wf = [1 1 1];
time_lapse = 0.1; % animation time lapse
filename = 'GPS_constellation &_working_principle_model.gif';

% Display settings
h = figure;
set(h,'Position',get(0,'ScreenSize'));
set(gcf,'Color',[0 0 0]);       
axis tight manual;


for k = 0:71 % loop over phi vector (longitude angle) number of elements
        
    surf(u,v,w,circshift(c,[0,k])), shading interp, hold on;
    colormap('Winter');
    axis equal, axis off;
    
    plot3(S1(1,:),S1(2,:),S1(3,:),'Color',wf), hold on;
    plot3(S2(1,:),S2(2,:),S2(3,:),'Color',wf), hold on;
    plot3(S3(1,:),S3(2,:),S3(3,:),'Color',wf), hold on;
    plot3(S4(1,:),S4(2,:),S4(3,:),'Color',wf), hold on;
    plot3(S5(1,:),S5(2,:),S5(3,:),'Color',wf), hold on;
    plot3(S6(1,:),S6(2,:),S6(3,:),'Color',wf), hold on;
        
    plot3(r*sin_quater_pi*cos(5*k*pi/180),r*sin_quater_pi*sin(5*k*pi/180),r*sin_quater_pi,'wx','MarkerSize',12,'Linewidth',3), hold on;
    
    X5 = [S5(1,1+mod(240+5*k,one_loop)) r*sin_quater_pi*cos(5*k*pi/180);...
          S5(2,1+mod(240+5*k,one_loop)) r*sin_quater_pi*sin(5*k*pi/180);...
          S5(3,1+mod(240+5*k,one_loop)) r*sin_quater_pi];
    
    if vecnorm(diff(X5,1,2)') <= rlim
        plot3(X5(1,:),X5(2,:),X5(3,:),'g--','Linewidth',2), hold on;
        marker_color = wf;        
    else        
        marker_color = [0 0 1];        
    end
    
    plot3(X5(1,1),X5(2,1),X5(3,1),'.','Color',marker_color,'MarkerSize',marker_size), hold on;
    
    
    X5a = [S5(1,1+mod(240+a+5*k,one_loop)) r*sin_quater_pi*cos(5*k*pi/180);...
           S5(2,1+mod(240+a+5*k,one_loop)) r*sin_quater_pi*sin(5*k*pi/180);...
           S5(3,1+mod(240+a+5*k,one_loop)) r*sin_quater_pi];
    
    if vecnorm(diff(X5a,1,2)') <= rlim
        plot3(X5a(1,:),X5a(2,:),X5a(3,:),'g--','Linewidth',2), hold on;
        marker_color = wf;        
    else        
        marker_color = [0 0 1];        
    end
    
    plot3(X5a(1,1),X5a(2,1),X5a(3,1),'.','Color',marker_color,'MarkerSize',marker_size), hold on;       
    
    
    X5b = [S5(1,1+mod(240+b+5*k,one_loop)) r*sin_quater_pi*cos(5*k*pi/180);...
           S5(2,1+mod(240+b+5*k,one_loop)) r*sin_quater_pi*sin(5*k*pi/180);...
           S5(3,1+mod(240+b+5*k,one_loop)) r*sin_quater_pi];
    
    if vecnorm(diff(X5b,1,2)') <= rlim
        plot3(X5b(1,:),X5b(2,:),X5b(3,:),'g--','Linewidth',2), hold on;        
        marker_color = wf;        
    else        
        marker_color = [0 0 1];        
    end
    
    plot3(X5b(1,1),X5b(2,1),X5b(3,1),'.','Color',marker_color,'MarkerSize',marker_size), hold on;
    
    
    X5f = [S5(1,1+mod(240+f+5*k,one_loop)) r*sin_quater_pi*cos(5*k*pi/180);...
           S5(2,1+mod(240+f+5*k,one_loop)) r*sin_quater_pi*sin(5*k*pi/180);...
           S5(3,1+mod(240+f+5*k,one_loop)) r*sin_quater_pi];
    
    if vecnorm(diff(X5f,1,2)') <= rlim
        plot3(X5f(1,:),X5f(2,:),X5f(3,:),'g--','Linewidth',2), hold on;        
        marker_color = wf;        
    else        
        marker_color = [0 0 1];        
    end
    
    plot3(X5f(1,1),X5f(2,1),X5f(3,1),'.','Color',marker_color,'MarkerSize',marker_size), hold on;
    
    
    X6 = [S6(1,1+mod(300+5*k,one_loop)) r*sin_quater_pi*cos(5*k*pi/180);...
          S6(2,1+mod(300+5*k,one_loop)) r*sin_quater_pi*sin(5*k*pi/180);...
          S6(3,1+mod(300+5*k,one_loop)) r*sin_quater_pi];
    
    if vecnorm(diff(X6,1,2)') <= rlim
        plot3(X6(1,:),X6(2,:),X6(3,:),'g--','Linewidth',2), hold on;        
        marker_color = wf;        
    else        
        marker_color = [0 1 0];        
    end

    plot3(X6(1,1),X6(2,1),X6(3,1),'.','Color',marker_color,'MarkerSize',marker_size), hold on;
    
    
    X6a = [S6(1,1+mod(300+a+5*k,one_loop)) r*sin_quater_pi*cos(5*k*pi/180);...
           S6(2,1+mod(300+a+5*k,one_loop)) r*sin_quater_pi*sin(5*k*pi/180);...
           S6(3,1+mod(300+a+5*k,one_loop)) r*sin_quater_pi];
    
    if vecnorm(diff(X6a,1,2)') <= rlim
        plot3(X6a(1,:),X6a(2,:),X6a(3,:),'g--','Linewidth',2), hold on;        
        marker_color = wf;        
    else        
        marker_color = [0 1 0];        
    end
    
    plot3(X6a(1,1),X6a(2,1),X6a(3,1),'.','Color',marker_color,'MarkerSize',marker_size), hold on;

    
    X6b = [S6(1,1+mod(300+b+5*k,one_loop)) r*sin_quater_pi*cos(5*k*pi/180);...
           S6(2,1+mod(300+b+5*k,one_loop)) r*sin_quater_pi*sin(5*k*pi/180);...
           S6(3,1+mod(300+b+5*k,one_loop)) r*sin_quater_pi];
    
    if vecnorm(diff(X6b,1,2)') <= rlim
        plot3(X6b(1,:),X6b(2,:),X6b(3,:),'g--','Linewidth',2), hold on;        
        marker_color = wf;        
    else        
        marker_color = [0 1 0];        
    end
    
    plot3(X6b(1,1),X6b(2,1),X6b(3,1),'.','Color',marker_color,'MarkerSize',marker_size), hold on;

    
    X6f = [S6(1,1+mod(300+f+5*k,one_loop)) r*sin_quater_pi*cos(5*k*pi/180);...
           S6(2,1+mod(300+f+5*k,one_loop)) r*sin_quater_pi*sin(5*k*pi/180);...
           S6(3,1+mod(300+f+5*k,one_loop)) r*sin_quater_pi];
    
    if vecnorm(diff(X6f,1,2)') <= rlim
        plot3(X6f(1,:),X6f(2,:),X6f(3,:),'g--','Linewidth',2), hold on;        
        marker_color = wf;        
    else        
        marker_color = [0 1 0];        
    end
    
    plot3(X6f(1,1),X6f(2,1),X6f(3,1),'.','Color',marker_color,'MarkerSize',marker_size), hold on;
    
    
    X4 = [S4(1,1+mod(180+5*k,one_loop)) r*sin_quater_pi*cos(5*k*pi/180);...
          S4(2,1+mod(180+5*k,one_loop)) r*sin_quater_pi*sin(5*k*pi/180);...
          S4(3,1+mod(180+5*k,one_loop)) r*sin_quater_pi];
    
    if vecnorm(diff(X4,1,2)') <= rlim
        plot3(X4(1,:),X4(2,:),X4(3,:),'g--','Linewidth',2), hold on;        
        marker_color = wf;        
    else        
        marker_color = [1 0 1];        
    end
    
    plot3(X4(1,1),X4(2,1),X4(3,1),'.','Color',marker_color,'MarkerSize',marker_size), hold on;

    
    X4a = [S4(1,1+mod(180+a+5*k,one_loop)) r*sin_quater_pi*cos(5*k*pi/180);...
          S4(2,1+mod(180+a+5*k,one_loop)) r*sin_quater_pi*sin(5*k*pi/180);...
          S4(3,1+mod(180+a+5*k,one_loop)) r*sin_quater_pi];
    
    if vecnorm(diff(X4a,1,2)') <= rlim
        plot3(X4a(1,:),X4a(2,:),X4a(3,:),'g--','Linewidth',2), hold on;        
        marker_color = wf;        
    else        
        marker_color = [1 0 1];        
    end
    
    plot3(X4a(1,1),X4a(2,1),X4a(3,1),'.','Color',marker_color,'MarkerSize',marker_size), hold on;

    
    X4b = [S4(1,1+mod(180+b+5*k,one_loop)) r*sin_quater_pi*cos(5*k*pi/180);...
          S4(2,1+mod(180+b+5*k,one_loop)) r*sin_quater_pi*sin(5*k*pi/180);...
          S4(3,1+mod(180+b+5*k,one_loop)) r*sin_quater_pi];
    
    if vecnorm(diff(X4b,1,2)') <= rlim
        plot3(X4b(1,:),X4b(2,:),X4b(3,:),'g--','Linewidth',2), hold on;        
        marker_color = wf;        
    else        
        marker_color = [1 0 1];        
    end
    
    plot3(X4b(1,1),X4b(2,1),X4b(3,1),'.','Color',marker_color,'MarkerSize',marker_size), hold on;

    
    X4f = [S4(1,1+mod(180+f+5*k,one_loop)) r*sin_quater_pi*cos(5*k*pi/180);...
          S4(2,1+mod(180+f+5*k,one_loop)) r*sin_quater_pi*sin(5*k*pi/180);...
          S4(3,1+mod(180+f+5*k,one_loop)) r*sin_quater_pi];
    
    if vecnorm(diff(X4f,1,2)') <= rlim
        plot3(X4f(1,:),X4f(2,:),X4f(3,:),'g--','Linewidth',2), hold on;        
        marker_color = wf;        
    else        
        marker_color = [1 0 1];        
    end
    
    plot3(X4f(1,1),X4f(2,1),X4f(3,1),'.','Color',marker_color,'MarkerSize',marker_size), hold on;
    
    
    X3 = [S3(1,1+mod(120+5*k,one_loop)) r*sin_quater_pi*cos(5*k*pi/180);...
          S3(2,1+mod(120+5*k,one_loop)) r*sin_quater_pi*sin(5*k*pi/180);...
          S3(3,1+mod(120+5*k,one_loop)) r*sin_quater_pi];
    
    if vecnorm(diff(X3,1,2)') <= rlim
        plot3(X3(1,:),X3(2,:),X3(3,:),'g--','Linewidth',2), hold on;        
        marker_color = wf;        
    else        
        marker_color = [1 1 0];        
    end
    
    plot3(X3(1,1),X3(2,1),X3(3,1),'.','Color',marker_color,'MarkerSize',marker_size), hold on;

    
    X3a = [S3(1,1+mod(120+a+5*k,one_loop)) r*sin_quater_pi*cos(5*k*pi/180);...
           S3(2,1+mod(120+a+5*k,one_loop)) r*sin_quater_pi*sin(5*k*pi/180);...
           S3(3,1+mod(120+a+5*k,one_loop)) r*sin_quater_pi];
    
    if vecnorm(diff(X3a,1,2)') <= rlim
        plot3(X3a(1,:),X3a(2,:),X3a(3,:),'g--','Linewidth',2), hold on;        
        marker_color = wf;        
    else        
        marker_color = [1 1 0];        
    end
    
    plot3(X3a(1,1),X3a(2,1),X3a(3,1),'.','Color',marker_color,'MarkerSize',marker_size), hold on;

    
    X3b = [S3(1,1+mod(120+b+5*k,one_loop)) r*sin_quater_pi*cos(5*k*pi/180);...
           S3(2,1+mod(120+b+5*k,one_loop)) r*sin_quater_pi*sin(5*k*pi/180);...
           S3(3,1+mod(120+b+5*k,one_loop)) r*sin_quater_pi];
    
    if vecnorm(diff(X3b,1,2)') <= rlim
        plot3(X3b(1,:),X3b(2,:),X3b(3,:),'g--','Linewidth',2), hold on;        
        marker_color = wf;        
    else        
        marker_color = [1 1 0];        
    end
    
    plot3(X3b(1,1),X3b(2,1),X3b(3,1),'.','Color',marker_color,'MarkerSize',marker_size), hold on;

    
    X3f = [S3(1,1+mod(120+f+5*k,one_loop)) r*sin_quater_pi*cos(5*k*pi/180);...
           S3(2,1+mod(120+f+5*k,one_loop)) r*sin_quater_pi*sin(5*k*pi/180);...
           S3(3,1+mod(120+f+5*k,one_loop)) r*sin_quater_pi];
    
    if vecnorm(diff(X3f,1,2)') <= rlim
        plot3(X3f(1,:),X3f(2,:),X3f(3,:),'g--','Linewidth',2), hold on;        
        marker_color = wf;        
    else        
        marker_color = [1 1 0];        
    end
    
    plot3(X3f(1,1),X3f(2,1),X3f(3,1),'.','Color',marker_color,'MarkerSize',marker_size), hold on;
    
    
    X2 = [S2(1,1+mod(60+5*k,one_loop)) r*sin_quater_pi*cos(5*k*pi/180);...
          S2(2,1+mod(60+5*k,one_loop)) r*sin_quater_pi*sin(5*k*pi/180);...
          S2(3,1+mod(60+5*k,one_loop)) r*sin_quater_pi];
    
    if vecnorm(diff(X2,1,2)') <= rlim
        plot3(X2(1,:),X2(2,:),X2(3,:),'g--','Linewidth',2), hold on;        
        marker_color = wf;        
    else        
        marker_color = [0 1 1];        
    end
    
    plot3(X2(1,1),X2(2,1),X2(3,1),'.','Color',marker_color,'MarkerSize',marker_size), hold on;
    

    X2a = [S2(1,1+mod(60+a+5*k,one_loop)) r*sin_quater_pi*cos(5*k*pi/180);...
           S2(2,1+mod(60+a+5*k,one_loop)) r*sin_quater_pi*sin(5*k*pi/180);...
           S2(3,1+mod(60+a+5*k,one_loop)) r*sin_quater_pi];
    
    if vecnorm(diff(X2a,1,2)') <= rlim
        plot3(X2a(1,:),X2a(2,:),X2a(3,:),'g--','Linewidth',2), hold on;        
        marker_color = wf;        
    else        
        marker_color = [0 1 1];        
    end
    
    plot3(X2a(1,1),X2a(2,1),X2a(3,1),'.','Color',marker_color,'MarkerSize',marker_size), hold on;
    

    X2b = [S2(1,1+mod(60+b+5*k,one_loop)) r*sin_quater_pi*cos(5*k*pi/180);...
           S2(2,1+mod(60+b+5*k,one_loop)) r*sin_quater_pi*sin(5*k*pi/180);...
           S2(3,1+mod(60+b+5*k,one_loop)) r*sin_quater_pi];
    
    if vecnorm(diff(X2b,1,2)') <= rlim
        plot3(X2b(1,:),X2b(2,:),X2b(3,:),'g--','Linewidth',2), hold on;        
        marker_color = wf;        
    else        
        marker_color = [0 1 1];        
    end
    
    plot3(X2b(1,1),X2b(2,1),X2b(3,1),'.','Color',marker_color,'MarkerSize',marker_size), hold on;
    
    
    X2f = [S2(1,1+mod(60+f+5*k,one_loop)) r*sin_quater_pi*cos(5*k*pi/180);...
           S2(2,1+mod(60+f+5*k,one_loop)) r*sin_quater_pi*sin(5*k*pi/180);...
           S2(3,1+mod(60+f+5*k,one_loop)) r*sin_quater_pi];

    if vecnorm(diff(X2f,1,2)') <= rlim
        plot3(X2f(1,:),X2f(2,:),X2f(3,:),'g--','Linewidth',2), hold on;        
        marker_color = wf;        
    else        
        marker_color = [0 1 1];        
    end
    
    plot3(X2f(1,1),X2f(2,1),X2f(3,1),'.','Color',marker_color,'MarkerSize',marker_size), hold on;
    
    
    X1 = [S1(1,1+mod(0+5*k,one_loop)) r*sin_quater_pi*cos(5*k*pi/180);...
          S1(2,1+mod(0+5*k,one_loop)) r*sin_quater_pi*sin(5*k*pi/180);...
          S1(3,1+mod(0+5*k,one_loop)) r*sin_quater_pi];
    
    if vecnorm(diff(X1,1,2)') <= rlim
        plot3(X1(1,:),X1(2,:),X1(3,:),'g--','Linewidth',2), hold on;        
        marker_color = wf;        
    else        
        marker_color = [1 0 0];        
    end
    
    plot3(X1(1,1),X1(2,1),X1(3,1),'.','Color',marker_color,'MarkerSize',marker_size), hold on;
    

    X1a = [S1(1,1+mod(0+a+5*k,one_loop)) r*sin_quater_pi*cos(5*k*pi/180);...
           S1(2,1+mod(0+a+5*k,one_loop)) r*sin_quater_pi*sin(5*k*pi/180);...
           S1(3,1+mod(0+a+5*k,one_loop)) r*sin_quater_pi];
    
    if vecnorm(diff(X1a,1,2)') <= rlim
        plot3(X1a(1,:),X1a(2,:),X1a(3,:),'g--','Linewidth',2), hold on;        
        marker_color = wf;        
    else        
        marker_color = [1 0 0];        
    end
    
    plot3(X1a(1,1),X1a(2,1),X1a(3,1),'.','Color',marker_color,'MarkerSize',marker_size), hold on;
    
    
    X1b = [S1(1,1+mod(0+b+5*k,one_loop)) r*sin_quater_pi*cos(5*k*pi/180);...
           S1(2,1+mod(0+b+5*k,one_loop)) r*sin_quater_pi*sin(5*k*pi/180);...
           S1(3,1+mod(0+b+5*k,one_loop)) r*sin_quater_pi];

    if vecnorm(diff(X1b,1,2)') <= rlim
        plot3(X1b(1,:),X1b(2,:),X1b(3,:),'g--','Linewidth',2), hold on;        
        marker_color = wf;        
    else        
        marker_color = [1 0 0];        
    end
    
    plot3(X1b(1,1),X1b(2,1),X1b(3,1),'.','Color',marker_color,'MarkerSize',marker_size), hold on;
    
    
    X1f = [S1(1,1+mod(0+f+5*k,one_loop)) r*sin_quater_pi*cos(5*k*pi/180);...
           S1(2,1+mod(0+f+5*k,one_loop)) r*sin_quater_pi*sin(5*k*pi/180);...
           S1(3,1+mod(0+f+5*k,one_loop)) r*sin_quater_pi];

    if vecnorm(diff(X1f,1,2)') <= rlim
        plot3(X1f(1,:),X1f(2,:),X1f(3,:),'g--','Linewidth',2), hold on;        
        marker_color = wf;        
    else        
        marker_color = [1 0 0];        
    end
    
    plot3(X1f(1,1),X1f(2,1),X1f(3,1),'.','Color',marker_color,'MarkerSize',marker_size), hold on;
    
    
    set(gca,'Color',[0 0 0]);                    
    ax = gca;
    ax.Clipping = 'off';    
    axis equal, axis off;
    zoom(1.25);   
    
    title('GPS constellation model and working principle','Color',wf,'FontSize',16);     
    
    drawnow;
    
    frame = getframe(h);    
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    
    % Write to the .gif file
    if k == 0
        imwrite(imind,cm,filename,'gif', 'Loopcount',Inf,'DelayTime',time_lapse);
    else
        imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',time_lapse);
    end
    
    clf;
    
end


end % gps_model_animation