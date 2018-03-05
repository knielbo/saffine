function result = multi_detrending(y, step_size, q, order)

% y: input data, stored as a row or column vector
% q: q spectrum

% q = [-1 -0.1 0.1 1:5];
% step_size = 1;

len = length(y);
imax = round(log2(len));
% order=2;
result = zeros(length(q) + 1, floor((imax - 2) / step_size) + 1);

k = 1;
for i = 1 : step_size : imax - 1
%     if mod(i, 5) == 0
%         i
%     end
    w = round(2^i + 1);
    if mod(w, 2) == 0
        w = w + 1;
    end
    [detrended_data, trend] = detrending_method(y, w, order);   
    result(1, k) = w;
    for j = 1 : length(q)
        % Euclidean norm
        result(j + 1, k) = (sum(abs(detrended_data) .^ q(j)) / (length(detrended_data) - 1))^(1/q(j)); 
        
        % result(j + 1, k) = (sum(abs(detrended_data - mean(detrended_data)) .^ q(j)) / (length(detrended_data) - 1))^(1/q(j));
        % earlier analysis suggests that without removing mean yields
        % more accurate estimate of H values
    end
    
    k = k+1;
end

result = log2(result);