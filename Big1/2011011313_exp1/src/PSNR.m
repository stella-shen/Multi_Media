function [ psnr ] = PSNR( In, Pn )
    mse = MSE( In, Pn );
    psnr = 10 * log10(255 * 255 / mse);
end

