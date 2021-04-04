% Part c_iii_Model2_Part2 (varying sigma, n constant) (Model is the one
% which is overfit to the true model)

% Everything same, but now only sigma varies


 count = 0;
 kernel = 3;                % for t generation, the true one        
 mse_vector = zeros(4,1);
 recon_mse_vector = zeros(4,1);
 kernel_mis = 5;
 w_average_matrix = zeros(kernel_mis,4);
 

n = 20;
A = zeros(2*n+1,kernel);
x_interim = -n:n;
x = transpose(x_interim*0.1);  % turning to vector

% A generation, true A, A that gives true t

for i = 1:kernel
    A(:,i) = x.^i;
end

% t generation
t = A(:,1) + 3*A(:,2) + 2*A(:,3);         % true t

% A, for our model, generation

A_mis = zeros(2*n+1,kernel_mis);

for i = 1:kernel_mis
    A_mis(:,i) = x.^(i-1);              % our kernel model
end

pm_i = pinv(A_mis);
w_true = pm_i*t;

 for sigma = [0.1,1,3,5]
    
    count = count + 1;
        
    w_average_interim = zeros(kernel_mis,1); 
    
    mse_interim = 0;
    
    recon_mse_interim = 0;
    
    for j = 1:100
        
        % v generation
        v = sigma*randn(2*n+1,1);
    
        % y generation
        y = t + v;           % observed y
    
        w_estimated = pm_i*y;       % calculating the estimate of w
        
        y_estimated = A_mis*w_estimated;
        
        w_average_interim = w_average_interim + w_estimated;  % running sum of w_average
        
        mse_interim = mse_interim + (norm(w_true - w_estimated))^2; % running sum of mse
        
        recon_mse_interim = recon_mse_interim + (norm(y - y_estimated))^2;

    end
    
    mse = mse_interim/100;
    recon_mse = recon_mse_interim/100;
    w_average = w_average_interim/100;
    
    mse_vector(count,1) = mse;
    recon_mse_vector(count,1) = recon_mse;
    w_average_matrix(:,count) = w_average;
    
    
    
end

sigma_range = [0.1;1;3;5];
disp("The true w vector for our model, which is obviously constant for all sigma, since n is constant is")
disp(w_true)
disp("The matrix of estimated w for our model(averaged over 100 iterations, for each sigma), where each column corresponds to a value of sigma and the column vector the vector of averaged w estimate, is")
disp(w_average_matrix)
disp("The averaged MSE of w over 100 iterations for each sigma, where rows represent MSE of w value for each sigma, is")
disp(mse_vector)
disp("The averaged MSE of reconfiguration over 100 iterations for each sigma, where rows represent MSE of reconfiguration value for each sigma, is")
disp(recon_mse_vector)

figure(1);
plot(sigma_range,mse_vector,'o-')
xlabel('values of sigma, n = 20 (constant)')
ylabel('MSE for w')

figure(2);
plot(sigma_range,recon_mse_vector,'o-')
xlabel('values of sigma, n = 20 (constant)')
ylabel('MSE for reconfiguration')




