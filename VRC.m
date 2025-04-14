% Vertical Redundency Check

clc;
clear;

% Input binary data
data_str = input('Enter binary data (e.g., 1011001): ', 's');

% Convert string to numeric array
data = data_str - '0';

% Count number of 1's
num_ones = sum(data);

% Determine parity bit (even parity)
if mod(num_ones, 2) == 1
    parity = 1;
else
    parity = 0;
end

% Prepend parity bit to the data
data_with_parity = [parity data];

% Display result
fprintf('Data with parity bit: ');
disp(data_with_parity);
