% Part c_iii_Model2_Part1 (varying n, sigma constant) (Model is the one
% which is overfit to the true model)

% Things same as before

 count = 0;
 kernel = 3;                % for t generation, the true one        
 mse_vector = zeros(5,1);
 recon_mse_vector = zeros(5,1);
 kernel_mis = 5;            % the overfit model
 w_average_matrix = zeros(kernel_mis,5);
 w_true_matrix = zeros(kernel_mis,5);
                   

 for n = [10,20,30,40,50]
    
    count = count + 1;
    A = zeros(2*n+1,kernel);
    sigma = 1;
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
    
    
    w_true = pinv(A_mis)*t;        
    w_true_matrix(:,count) = w_true;
    
    w_average_interim = zeros(kernel_mis,1); 
    
    mse_interim = 0;
    
    recon_mse_interim = 0;
    
    for j = 1:100
        
        % v generation
        v = sigma*randn(2*n+1,1);
    
        % y generation
        y = t + v;           % observed y
    
        w_estimated = pinv(A_mis)*y;       % calculating the estimate of w
        
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

n_range = [10;20;30;40;50];
disp("The matrix of true w for our model, where each column corresponds to a value of n and the column vector the vector of w, is")
disp(w_true_matrix)
disp("The matrix of estimated w for our model(averaged over 100 iterations, for each n), where each column corresponds to a value of n and the column vector the vector of averaged w estimate, is")
disp(w_average_matrix)
disp("The averaged MSE of w over 100 iterations for each n, where rows represent MSE of w value for each n, is")
disp(mse_vector)
disp("The averaged MSE of reconfiguration over 100 iterations for each n, where rows represent MSE of reconfiguration value for each n, is")
disp(recon_mse_vector)

figure(1);
plot(n_range,mse_vector,'o-')
xlabel('values of n, sigma = 1 (constant)')
ylabel('MSE for w')

figure(2);
plot(n_range,recon_mse_vector,'o-')
xlabel('values of n, sigma = 1 (constant)')
ylabel('MSE for reconfiguration')




