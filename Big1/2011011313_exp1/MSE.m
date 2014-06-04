function [ mse ] = MSE( In, Pn )
    temp_sum = sum(sum((In-Pn).^2));
    mse = temp_sum / (512 * 512);
end

