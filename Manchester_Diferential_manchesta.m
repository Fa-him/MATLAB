clc;
clear;
close all;

input_signal = [ 0 1 1 0 1 0 1 1 1 0 0 1 0 0 1 ];
n = length(input_signal);
bitrate = 1;
samples_per_bit = 100;
time = linspace(0, n, n * samples_per_bit);
half = n / 2;
manchester = zeros(1, length(time));
diff_manchester = zeros(1, length(time));
combined = zeros(1, length(time));

prev1 = -1;
prev2 = 1;

for i = 1:n
    t_index = (i - 1) * samples_per_bit + 1 : i * samples_per_bit / 2;
    t_index2 = (i - 1) * samples_per_bit + samples_per_bit / 2 + 1 : i * samples_per_bit;
    
    if i <= half
        if input_signal(i) == 0
            manchester(t_index) = 1;
            manchester(t_index2) = -1;
        else
            manchester(t_index) = -1;
            manchester(t_index2) = 1;
        end
        combined(t_index) = manchester(t_index);
        combined(t_index2) = manchester(t_index2);
    else
        if input_signal(i) == 1
            diff_manchester(t_index) = prev2;
            diff_manchester(t_index2) = prev1;
        else
            diff_manchester(t_index) = prev1;
            diff_manchester(t_index2) = prev2;
        end
        combined(t_index) = diff_manchester(t_index);
        combined(t_index2) = diff_manchester(t_index2);
        
        prev1 = diff_manchester(t_index2(end));
        prev2 = -prev1;
    end
end

figure;
subplot(2,2,1);
stem(0:n-1, input_signal, 'filled', 'linewidth', 2);
ylabel('Input Signal');
xlabel('Bit Index');
title('Input Binary Signal');
grid on;
ylim([-2 2]);

subplot(2,2,2);
plot(time(1:round(half * samples_per_bit)), manchester(1:round(half * samples_per_bit)), 'linewidth', 2);
ylabel('Manchester');
xlabel('Time (s)');
title('Manchester Encoding (First Half)');
grid on;
ylim([-2 2]);

subplot(2,2,3);
plot(time(round(half * samples_per_bit) + 1:end), diff_manchester(round(half * samples_per_bit) + 1:end), 'linewidth', 2);
ylabel('Differential Manchester');
xlabel('Time (s)');
title('Differential Manchester Encoding (Second Half)');
grid on;
ylim([-2 2]);

subplot(2,2,4);
plot(time, combined, 'linewidth', 2);
ylabel('Combined');
xlabel('Time (s)');
title('Combined');
grid on;
ylim([-2 2]);

