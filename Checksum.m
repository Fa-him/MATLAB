clc;
clear;
% Sender side
n = input('Enter how many bits in the stream? ');
s = input('Enter the segment size: ');
bit_stream_str = input('Enter the bit streams: ', 's');

bit_stream = str2num(bit_stream_str(:))';

remainder = mod(length(bit_stream), s);
if remainder ~= 0
    padding = zeros(1, s - remainder);
    bit_stream = [bit_stream padding];
end

segments = reshape(bit_stream, s, [])';

sum_bits = segments(1, :);

for i = 2:size(segments, 1)
    sum_val = bin2dec(num2str(sum_bits));
    seg_val = bin2dec(num2str(segments(i, :)));
    total = sum_val + seg_val;
    temp_sum = dec2bin(total, s);

    while length(temp_sum) > s
        carry = temp_sum(1:end-s);
        lower = temp_sum(end-s+1:end);
        carry_val = bin2dec(carry);
        lower_val = bin2dec(lower);
        total = carry_val + lower_val;
        temp_sum = dec2bin(total, s);
    end

    sum_bits = temp_sum - '0';
end

a = mod(~sum_bits, 2);

encoded_result = [bit_stream a];
disp(['Data sent: ' num2str(encoded_result)]);

% Receiver side

received_bit_stream = encoded_result;

remainder = mod(length(received_bit_stream), s);
if remainder ~= 0
    padding = zeros(1, s - remainder);
    received_bit_stream = [received_bit_stream padding];
end

segments_received = reshape(received_bit_stream, s, [])';

sum_bits_received = segments_received(1, :);

for i = 2:size(segments_received, 1)
    sum_val = bin2dec(num2str(sum_bits_received));
    seg_val = bin2dec(num2str(segments_received(i, :)));
    total = sum_val + seg_val;
    temp_sum = dec2bin(total, s);

    while length(temp_sum) > s
        carry = temp_sum(1:end-s);
        lower = temp_sum(end-s+1:end);
        carry_val = bin2dec(carry);
        lower_val = bin2dec(lower);
        total = carry_val + lower_val;
        temp_sum = dec2bin(total, s);
    end

    sum_bits_received = temp_sum - '0';
end

a_received = mod(~sum_bits_received, 2);

if all(a_received == 0)
    disp('No error detected');
else
    disp('Error detected');
end
