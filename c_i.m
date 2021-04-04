% Part a and b done on paper
% Part c_i (varying n, sigma constant)

 count = 0;
 kernel = 3;                % based on w_true = [1,3,2]'
 mse_vector = zeros(5,1);
 w_average_matrix = zeros(kernel,5);
 w_true_matrix = zeros(kernel,5);
                   

 for n = [10,20,30,40,50]
    
    count = count + 1;
    A = zeros(2*n+1,kernel);
    sigma = 1;
    x_interim = -n:n;
    x = transpose(x_interim*0.1);  % turning to vector
    
    % A generation
    
    for i = 1:kernel
        A(:,i) = x.^i;
    end
    
    % t generation
    t = A(:,1) + 3*A(:,2) + 2*A(:,3);
    
    w_true = pinv(A)*t;         % calculating the true w directly from t
    w_true_matrix(:,count) = w_true;
    
    w_average_interim = zeros(kernel,1); 
    
    mse_interim = 0;
    
    for j = 1:100
        
        % v generation
        v = sigma*randn(2*n+1,1);
    
        % y generation
        y = t + v;
    
        w_estimated = pinv(A)*y;       % calculating the estimate of w
        
        w_average_interim = w_average_interim + w_estimated;  % running sum of w_average
        
        mse_interim = mse_interim + (norm(w_true - w_estimated))^2; % running sum of mse
        

    end
    
    mse = mse_interim/100;
    w_average = w_average_interim/100;
    
    mse_vector(count,1) = mse;
    w_average_matrix(:,count) = w_average;
    
    
    
end

n_range = [10;20;30;40;50];
disp("The matrix of true w, where each column corresponds to a value of n and the column vector the vector of w, is")
disp(w_true_matrix)
disp("The matrix of estimated w (averaged over 100 iterations, for each n), where each column corresponds to a value of n and the column vector the vector of averaged w estimate, is")
disp(w_average_matrix)
disp("The averaged MSE over 100 iterations for each n, where rows represent MSE value for each n, is")
disp(mse_vector)

plot(n_range,mse_vector,'-o')
xlabel('values of n, sigma = 1 (constant)')
ylabel('MSE')




