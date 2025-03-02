clc;
clear;
close all;

input_signal = [0 0 0 0 0 0 1 0];
n = length(input_signal);
bit_rate = 1;
samples_per_bit = 100;
time = linspace(0, n, n * samples_per_bit);

rz_signal = zeros(1, length(time));
nrz_signal = zeros(1, length(time));

for i = 1:n
    t_index = (i - 1) * samples_per_bit + 1 : i * samples_per_bit;
    
    
    if input_signal(i) == 0
        nrz_signal(t_index) = 1;
    else
        nrz_signal(t_index) = -1;
    end
    
    mid = round(samples_per_bit / 2);
    if input_signal(i) == 1
        rz_signal(t_index(1:mid)) = 1;
        rz_signal(t_index(mid+1:end)) = 0;
    else
        rz_signal(t_index(1:mid)) = -1;
        rz_signal(t_index(mid+1:end)) = 0;
    end
end





figure;

subplot(3,1,1);
stem(0:n-1, input_signal, 'filled', 'linewidth', 2);
ylabel('Input Signal');
xlabel('Bit Index'); 
grid on;
axis([0 n -0.5 1.5]);
title('Input Binary Signal');

subplot(3,1,2);
plot(time, rz_signal, 'linewidth', 2);
title('RZ Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
ylim([-1.5 1.5]);

subplot(3,1,3);
plot(time, nrz_signal, 'linewidth', 2);
title('NRZ Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
ylim([-1.5 1.5]);
