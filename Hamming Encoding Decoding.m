function Hamming()
    choice=input('Choose:\n1.Encode data\n2.Decode and correct Hamming code\n', 's');
    if strcmp(choice, '1')
        data_input=input('Enter data bits: ', 's');
        if all(data_input=='0'| data_input=='1')
            code=generate_hamming_code(data_input);
            fprintf('Hamming code : %s\n', code);
        else
            disp('Invalid input.(0/1)');
        end
    elseif strcmp(choice, '2')
        hamming_input=input('Enter received hamming code: ', 's');
        if all (hamming_input=='0' | hamming_input=='1')
            detect_error_and_correct(hamming_input);
        else
            disp('Invalid input.(0/1)');
        end
    else
        disp('Invalid option. (0/1)');
    end
end

function r=calculate_redundant_bits(m)
    r=0;
    while 2^r< m+r+1
        r=r+1;
    end
end

function code=generate_hamming_code(data_str)
    data_bits=double(data_str)-'0';
    m=length(data_bits);
    r=calculate_redundant_bits(m);
    total_bits=m+r;
    hamming=NaN(1,total_bits);
    
    j=1;
    for i=total_bits:-1:1
        if bitand(i, i-1)~=0
            hamming(i)=data_bits(j);
            j=j+1;
        end
    end
    
    for i=0:r-1
        parity_pos=2^i;
        parity=0;
        for j=parity_pos:2*parity_pos:total_bits
            for k=j:min(j+parity_pos-1, total_bits)
                if ~isnan(hamming(k))
                    parity=bitxor(parity, hamming(k));
                end
            end
        end
        hamming(parity_pos)=parity;
    end
    
    code=num2str(hamming(~isnan(hamming)));
    code=regexprep(code, '\s+', '');
end

function detect_error_and_correct(code_str)
    bits=double(code_str)-'0';
    bits=fliplr(bits);
    n=length(bits);
    r=0;
    while 2^r<n+1
        r=r+1;
    end
    
    error_pos=0;
    for i =0:r-1
        parity_pos=2^i;
        parity=0;
        for j=parity_pos:2*parity_pos:n
            for k=j:min(j+parity_pos-1,n)
                parity=bitxor(parity, bits(k));
            end
        end
        if parity~=0
            error_pos=error_pos+parity_pos;
        end
    end
    
    if error_pos~=0
        fprintf('Error detected at : %d\n', error_pos);
        bits(error_pos)=bitxor(bits(error_pos),1);
        corrected=fliplr(bits);
        fprintf('Corrected Hamming Code: %s\n', num2str(corrected));
    else
        corrected=fliplr(bits);
        disp('No error');
        fprintf('Hamming Code; %s\n', num2str(corrected));
    end
    
    data_bits=[];
    for i =1:n
        if bitand(i, i-1)~=0
            data_bits=[data_bits, corrected(n-i+1)];
        end
    end
    fprintf('Data bits: %s\n', num2str(data_bits));
end
