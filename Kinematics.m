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

jack1_b = [str2double(char(answer(1))) str2double(char(answer(2)))];
jack2_b = [str2double(char(answer(3))) str2double(char(answer(4)))];
jack3_b = [str2double(char(answer(5))) str2double(char(answer(6)))];


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
theta_final = str2double(char(answer(2)))*pi/180;
phi_final = str2double(char(answer(3)))*pi/180;

%% Final end locations
jack1_initial = [jack1_p z_0];
jack1_final = 