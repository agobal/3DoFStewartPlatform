%% Motion control for a 3 DoF Stewart platform mechanism
%
% Arash Gobal
%
% This program provides the final length of the hydraulic jacks of a 3
% degree of freedom Stewart platform given the initial and limit length of
% jacks, their base positions and width and length of the platform and the
% platforms final required position (desired elevation and roll and pitch
% angles).
%
% For the sake of simplicity, jacks are assumed to be identical
%

%% Geometry of the mechanism

% Platform dimensions

prompt = {'Length (m):', 'Width (m):'};
dlg_title = 'Platform geometry';
num_lines = 1;
defaultans = {'1', '0.5'};
answer = inputdlg(prompt, dlg_title, num_lines, defaultans);

platform_length = str2double(char(answer(1)));
platform_width = str2double(char(answer(2)));

% Jack properties

prompt = {'Closed length (m):', 'Limit length (m):'};
dlg_title = 'Jack properties';
num_lines = 1;
defaultans = {'0.5', '1'};
answer = inputdlg(prompt, dlg_title, num_lines, defaultans);

closed_length = str2double(char(answer(1)));
limit_length = str2double(char(answer(2)));

% Jack base locations

prompt = {'X-1 (m):', 'Y-1 (m):', 'X-2 (m):', 'Y-2 (m):', 'X-3 (m):', 'Y-3 (m):'};
dlg_title = 'Jack basis';
num_lines = 1;
defaultans = {'1', '0', '-1', '0.25', '-1', '-0.25'};
answer = inputdlg(prompt, dlg_title, num_lines, defaultans);

jack1_b = [str2double(char(answer(1))) str2double(char(answer(2))) 0];
jack2_b = [str2double(char(answer(3))) str2double(char(answer(4))) 0];
jack3_b = [str2double(char(answer(5))) str2double(char(answer(6))) 0];


% Jack-to-platform connections

prompt = {'X-1 (m):', 'Y-1 (m):', 'X-2 (m):', 'Y-2 (m):', 'X-3 (m):', 'Y-3 (m):'};
dlg_title = 'Jack-to-platform connections';
num_lines = 1;
defaultans = {'1', '0', '-1', '0.25', '-1', '-0.25'};
answer = inputdlg(prompt, dlg_title, num_lines, defaultans);

jack1_p = [str2double(char(answer(1))) str2double(char(answer(2)))];
jack2_p = [str2double(char(answer(3))) str2double(char(answer(4)))];
jack3_p = [str2double(char(answer(5))) str2double(char(answer(6)))];

% Initial platform elevation and angles
z_0 = closed_length;    % initial elevation
theta_0 = 0;    % initial roll angle
phi_0 = 0;      % initial pitch angle

% Desired final platform location (central location and roll and pitch
% angles)

prompt = {'Central elevation (m):', 'Roll angle (deg):', 'Pitch angle (deg):'};
dlg_title = 'Final platform location';
num_lines = 1;
defaultans = {'0.75', '5', '10'};
answer = inputdlg(prompt, dlg_title, num_lines, defaultans);

z_final = str2double(char(answer(1)));
theta = str2double(char(answer(2)))*pi/180;
phi = str2double(char(answer(3)))*pi/180;

%% Final end locations
jack1_initial = [jack1_p z_0];
jack1_final = [jack1_initial(1)*cos(phi) jack1_initial(2)*cos(theta) jack1_initial(3)+jack1_initial(1)*sin(phi)+jack1_initial(2)*sin(theta)];
jack1_length = sqrt((jack1_final(1) - jack1_b(1))^2 + (jack1_final(2) - jack1_b(2))^2 + (jack1_final(3) - jack1_b(3))^2);

jack2_initial = [jack2_p z_0];
jack2_final = [jack2_initial(1)*cos(phi) jack2_initial(2)*cos(theta) jack2_initial(3)+jack2_initial(1)*sin(phi)+jack2_initial(2)*sin(theta)];
jack2_length = sqrt((jack2_final(1) - jack2_b(1))^2 + (jack2_final(2) - jack2_b(2))^2 + (jack2_final(3) - jack2_b(3))^2);

jack3_initial = [jack3_p z_0];
jack3_final = [jack3_initial(1)*cos(phi) jack3_initial(2)*cos(theta) jack3_initial(3)+jack3_initial(1)*sin(phi)+jack3_initial(2)*sin(theta)];
jack3_length = sqrt((jack3_final(1) - jack3_b(1))^2 + (jack3_final(2) - jack3_b(2))^2 + (jack3_final(3) - jack3_b(3))^2);

jack1_length
jack2_length
jack3_length

% Plot the movement and base
xb = [jack1_b(1) jack2_b(1) jack3_b(1)];
yb = [jack1_b(2) jack2_b(2) jack3_b(2)];
zb = [jack1_b(3) jack2_b(3) jack3_b(3)];

x0 = [jack1_initial(1) jack2_initial(1) jack3_initial(1)];
y0 = [jack1_initial(2) jack2_initial(2) jack3_initial(2)];
z0 = [jack1_initial(3) jack2_initial(3) jack3_initial(3)];
plot3(1,1,1,-1,-1,0)
hold on

plot3([xb(1) x0(1)], [yb(1) y0(1)], [zb(1) z0(1)]);
plot3([xb(2) x0(2)], [yb(2) y0(2)], [zb(2) z0(2)]);
plot3([xb(3) x0(3)], [yb(3) y0(3)], [zb(3) z0(3)]);
fill3(x0,y0,z0,1);
hold off

for i = 1:100
    x = [(x0(1) + i*(jack1_final(1) - x0(1))/100) (x0(2) + i*(jack2_final(1) - x0(2))/100) (x0(3) + i*(jack3_final(1) - x0(3))/100)];
    y = [(y0(1) + i*(jack1_final(2) - y0(1))/100) (y0(2) + i*(jack2_final(2) - y0(2))/100) (y0(3) + i*(jack3_final(2) - y0(3))/100)];
    z = [(z0(1) + i*(jack1_final(3) - z0(1))/100) (z0(2) + i*(jack2_final(3) - z0(2))/100) (z0(3) + i*(jack3_final(3) - z0(3))/100)];
    plot3(1,1,1,-1,-1,0)
    hold on
    plot3([xb(1) x(1)], [yb(1) y(1)], [zb(1) z(1)]);
    plot3([xb(2) x(2)], [yb(2) y(2)], [zb(2) z(2)]);
    plot3([xb(3) x(3)], [yb(3) y(3)], [zb(3) z(3)]);
    fill3(x,y,z,1)
    hold off
    pause(0.1);
end
