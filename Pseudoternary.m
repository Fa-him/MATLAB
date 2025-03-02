clc;
clear;
close all;

% Define input binary signal
input_signal = [0 1 1 0 1 1 0];
n = length(input_signal);
bitrate = 1;
samples_per_bit = 100;
time = linspace(0, n, n * samples_per_bit); 

% Generate Pseudoternary Signal
pseudoternary_signal = zeros(1, length(time));
current_level = 1;
for i = 1:n
    t_index = (i - 1) * samples_per_bit + 1 : i * samples_per_bit; 
    
    if input_signal(i) == 0
        pseudoternary_signal(t_index) = current_level;
        current_level = -current_level;
    end
end

% Plot Signals
figure;
subplot(2,1,1);
stem(0:n-1, input_signal, 'filled', 'linewidth', 2);
ylabel('Input Signal');
xlabel('Bit Index');
grid on;
axis([0 n -0.5 1.5]); 

title('Input Binary Signal');

subplot(2,1,2);
plot(time, pseudoternary_signal, 'linewidth', 2);
ylabel('Pseudoternary Signal');
xlabel('Time (s)');
grid on;
axis([0 n -1.5 1.5]);
title('Pseudoternary Signal');
