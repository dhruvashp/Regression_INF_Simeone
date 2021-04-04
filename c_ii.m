% Part c_ii (varying sigma, n constant)


kernel = 3;                % based on w_true = [1,3,2]'
mse_vector = zeros(4,1);
w_average_matrix = zeros(kernel,4);

 
n = 20;
A = zeros(2*n+1,kernel);
x_interim = -n:n;
x = transpose(x_interim*0.1);  % turning to vector

% A generation

for i = 1:kernel
    A(:,i) = x.^i;
end

% t generation
t = A(:,1) + 3*A(:,2) + 2*A(:,3);

mp_i = pinv(A); % as A stays same, irrespective of sigma, for a given n, we have moore-penrose inverse of A constant throughout

w_true = mp_i*t;         % calculating the true w directly from t
 
count = 0;

 for sigma = [0.1,1,3,5]
     
    count = count + 1;

    w_average_interim = zeros(kernel,1); 
    
    mse_interim = 0;
    
    for j = 1:100
        
        % v generation
        v = sigma*randn(2*n+1,1);
    
        % y generation
        y = t + v;
    
        w_estimated = mp_i*y;       % calculating the estimate of w
        
        w_average_interim = w_average_interim + w_estimated;  % running sum of w_average
        
        mse_interim = mse_interim + (norm(w_true - w_estimated))^2; % running sum of mse
        

    end
    
    mse = mse_interim/100;
    w_average = w_average_interim/100;
    
    mse_vector(count,1) = mse;
    w_average_matrix(:,count) = w_average;
    
    
    
end

sigma_range = [0.1;1;3;5];
disp("The matrix of true w, obtained same for all sigma (obviously) is")
disp(w_true)
disp("The matrix of estimated w (averaged over 100 iterations, for each sigma), where each column corresponds to a value of sigma and the column vector the vector of averaged w estimate, is")
disp(w_average_matrix)
disp("The averaged MSE over 100 iterations for each sigma, where rows represent MSE value for each sigma, is")
disp(mse_vector)

plot(sigma_range,mse_vector,'-o')
xlabel('values of sigma, n = 20 (constant)')
ylabel('MSE')




