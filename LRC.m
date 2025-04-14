% Longitudinal Redundency Check 
clc;
clear;

% Define the 4 data blocks (rows)
data = [
    1 1 1 0 0 1 1 1;
    1 1 0 1 1 1 0 1;
    0 0 1 1 1 0 0 1;
    1 0 1 0 1 0 0 1
];

% Calculate LRC row (even parity column-wise)
lrc = mod(sum(data), 2);

% Append LRC as the last row
transmitted_data = [data; lrc];

% Display transmitted data
disp('Transmitted Data with LRC (Last Row):');
disp(transmitted_data);
