clc;
clear;

% Inputs
dividend = '1101010';  
divisor = '1101';   

% Convert to numeric arrays
dividend_bits = double(dividend) - '0';
divisor_bits = double(divisor) - '0';

% Get length of divisor
L = length(divisor_bits);

% Step 1: Append L-1 zeros to the dividend
dividend_padded = [dividend_bits, zeros(1, L-1)];

% Step 2: Perform binary division (Mod-2) on the padded dividend
remainder = dividend_padded;

for i = 1:(length(dividend_padded) - L + 1)
    if remainder(i) == 1
        % XOR operation between the remainder and the divisor
        remainder(i:i+L-1) = bitxor(remainder(i:i+L-1), divisor_bits);
    end
end

% Step 3: Extract the final remainder (CRC), which is L-1 bits long
final_remainder = remainder(end - (L - 2):end);

% Step 4: Replace the last L-1 zeros in the padded dividend with the CRC
codeword = [dividend_bits, final_remainder];

% Display the results
disp('Remainder (CRC):');
disp(num2str(final_remainder));

disp('Data to be sent with CRC:');
disp(num2str(codeword));
