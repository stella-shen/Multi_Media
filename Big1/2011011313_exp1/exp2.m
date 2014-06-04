clc;
close all;
clear all;

%Transfer To Gray-Scale
IMG_original = imread('lena.bmp');
IMG_original = imresize(IMG_original, [512, 512])
subplot(2, 2, 1);
%size(IMG_original)
imshow(IMG_original);
title('Original Image');
IMG_Gray = rgb2gray(IMG_original);
subplot(2, 2, 2);
imshow(IMG_Gray);
title('Gray Image');
imwrite(IMG_Gray, 'F:\Programming\多媒体\hw\Big1\2011011313_exp1\res_pics\exp2\lenaGray.bmp');
gray = double(IMG_Gray);

Q = [16 11 10 16 24 40 51 61
     12 12 14 19 26 58 60 55
     14 13 16 24 40 57 69 56
     14 17 22 29 51 87 80 62
     18 22 37 56 68 109 103 77
     24 35 55 64 81 104 113 92
     49 64 78 87 103 121 120 101
     72 92 95 98 112 100 103 99];
 
 Cannon = [1 1 1 2 3 6 8 10 
          1 1 2 3 4 8 9 8 
          2 2 2 3 6 8 10 8 
          2 2 3 4 7 12 11 9 
          3 3 8 11 10 16 15 11 
          3 5 8 10 12 15 16 13 
          7 10 11 12 15 17 17 14 
          14 13 13 15 15 14 14 14];
 
 Nikon = [2 1 1 2 3 5 6 7 
          1 1 2 2 3 7 7 7  
          2 2 2 3 5 7 8 7 
          2 2 3 3 6 10 10 7 
          2 3 4 7 8 13 12 9 
          3 4 7 8 10 12 14 11 
          6 8 9 10 12 15 14 12 
          9 11 11 12 13 12 12 12];

%partition to blocks
blocks = mat2cell(gray, ones(512/8, 1)*8, ones(512/8, 1)*8);
% Applying 2D DCT
for i = 1 : 1 : 512/8
    for j = 1 : 1 : 512/8
        temp{i, j} = dct2(blocks{i, j});
    end
end
encode_2D_blocks = cell2mat(temp);

%Using Q to quantize the DCT coefficients
for i = 1 : 1 : 512/8
    for j = 1 : 1 : 512/8
        temp1{i, j} = round(temp{i, j}./Q).*Q;
    end
end
encode_2D_blocks_Q = cell2mat(temp1);

%Applying 2D IDCT and calculate the PSNR
sum1 = 0;
for i = 1 : 1 : 512/8
    for j = 1 : 1 : 512/8
        temp2{i, j} = idct2(temp1{i, j});
        psnr(i, j) = PSNR(blocks{i, j}, temp2{i, j});
        sum1 = sum1 + psnr(i, j);
    end
end 
save('F:\Programming\多媒体\hw\Big1\2011011313_exp1\exp2_data_res\Q_block_psnr.txt', 'psnr', '-ascii', '-tabs');

%Calculate the average PSNR
decode_2D_blocks_Q = cell2mat(temp2);
decode_2D_blocks_Q_img = mat2gray(decode_2D_blocks_Q);
psnr_avg = sum1 / (64 * 64);
disp(psnr_avg);
subplot(2, 2, 3);
imshow(decode_2D_blocks_Q_img);
title('decode 2D blocks Q img');
imwrite(decode_2D_blocks_Q_img, 'F:\Programming\多媒体\hw\Big1\2011011313_exp1\res_pics\exp2\decode_2D_blocks_Q.bmp');

%Use a*Q as quantization matrix
cnt = 1;
for a = 0.1 : 0.1 : 2
    %quantize the DCT coefficients
    for i = 1 : 1 : 512/8
        for j = 1 : 1 : 512/8
            temp3{i, j} = round(temp{i, j}./(a*Q)).*(a*Q);
        end
    end
    %Applying 2D IDCT and calculate the PSNR
    for i = 1 : 1 : 512/8
        for j = 1 : 1 : 512/8
            temp4{i, j} = idct2(temp3{i, j});
            psnr1(i, j) = PSNR(blocks{i, j}, temp4{i, j});
        end
    end
    filename1 = strcat('F:\Programming\多媒体\hw\Big1\2011011313_exp1\exp2_data_res\Q_block_psnr', num2str(a));
    filename1_txt = strcat(filename1, '.txt');
    save(filename1_txt, 'psnr1', '-ascii', '-tabs');
    cur_mat = cell2mat(temp4);
    psnr_arr(cnt) = PSNR(gray, cur_mat);
    filename2 = strcat('F:\Programming\多媒体\hw\Big1\2011011313_exp1\res_pics\exp2\as\Q_block_psnr', num2str(a));
    filename_img = strcat(filename2, '.bmp');
    imwrite(mat2gray(cur_mat), filename_img);
    cnt = cnt + 1;
end
%plot the curve of a and PSNR
figure()
a = 0.1 : 0.1 : 2
plot(a, psnr_arr);

%cannon Q
sum2 = 0;
for i = 1 : 1 : 512/8
    for j = 1 : 1 : 512/8
        temp5{i, j} = round(temp{i, j}./Cannon).*Cannon;
        temp6{i, j} = idct2(temp5{i, j});
        psnr_cannon(i, j) = PSNR(blocks{i, j}, temp6{i, j});
        sum2 = sum2 + psnr_cannon(i, j);
    end
end
Cannon_blocks = cell2mat(temp6);
psnr_cannon_aver = sum2 / (64 * 64);
disp(psnr_cannon_aver);
save('F:\Programming\多媒体\hw\Big1\2011011313_exp1\exp2_data_res\Q_block_psnr_cannon.txt', 'psnr_cannon', '-ascii', '-tabs');
Cannon_blocks_img = mat2gray(Cannon_blocks);
imwrite(Cannon_blocks_img, 'F:\Programming\多媒体\hw\Big1\2011011313_exp1\res_pics\exp2\Cannon_blocks_img.bmp');

%Nikon Q
sum3 = 0;
for i = 1 : 1 : 512/8
    for j = 1 : 1 : 512/8
        temp7{i, j} = round(temp{i, j}./Nikon).*Nikon;
        temp8{i, j} = idct2(temp7{i, j});
        psnr_nikon(i, j) = PSNR(blocks{i, j}, temp8{i, j});
        sum3 = sum3 + psnr_nikon(i, j);
    end
end
Nikon_blocks = cell2mat(temp8);
psnr_Nikon_aver = sum3 / (64 * 64);
disp(psnr_Nikon_aver);
save('F:\Programming\多媒体\hw\Big1\2011011313_exp1\exp2_data_res\Q_block_psnr_nikon.txt', 'psnr_nikon', '-ascii', '-tabs');
Nikon_blocks_img = mat2gray(Nikon_blocks);
imwrite(Nikon_blocks_img, 'F:\Programming\多媒体\hw\Big1\2011011313_exp1\res_pics\exp2\Nikon_blocks_img.bmp');
