clc;
clear;
close all;

% Define input binary signal
input_signal= [ 0 1 1 0 0 1 0 1 0 ];
n=length(input_signal);
bit_rate=1;
samples_per_bit=100;
time=linspace(0,n,n*samples_per_bit);

% Generate Unipolar NRZ Signal
unipolar_nrz=zeros(1,length(time));
for i=1:n
    t_index=(i-1)*samples_per_bit+1 : i*samples_per_bit;
    unipolar_nrz(t_index)=input_signal(i);
end

% Plot Signals
figure;
subplot(2,1,1);
stem(0:n-1, input_signal, 'filled', 'linewidth', 2);
ylabel('Input Signal');
xlabel('Bit Index'); 
grid on;
axis([0 n -0.5 1.5]); 

subplot(2,1,2);
plot(time, unipolar_nrz, 'linewidth', 2);
ylabel('Unipolar NRZ');
xlabel('Time (s)'); 
grid on;
axis([0 n -0.5 1.5]);

