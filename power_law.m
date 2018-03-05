
function [nn, x_train] = power_law(x,bin_num)

%[N_train, x_train] = hist(log10(x),bin_num);
[N_train, x_train] = hist(log10(x),bin_num);
N_train = N_train/(sum(N_train)); %/(x_train(2)-x_train(1));
nn=N_train;
nn(1) = sum(N_train);
for i=2:bin_num
    nn(i) = nn(i-1) - N_train(i-1);
end

