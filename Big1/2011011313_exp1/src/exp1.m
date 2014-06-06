clc;
close all;
clear all;

figure();
%Transfer To Gray-Scale
IMG_original = imread('lena.bmp');
IMG_original = imresize(IMG_original, [512, 512])
subplot(3, 2, 1);
%size(IMG_original)
imshow(IMG_original);
title('Original Image');
IMG_Gray = rgb2gray(IMG_original);
subplot(3, 2, 2);
imshow(IMG_Gray);
title('Gray Image');
imwrite(IMG_Gray, 'F:\Programming\多媒体\hw\Big1\2011011313_exp1\res_pics\exp1\lenaGray.bmp');
gray = double(IMG_Gray);

%1D-DCT on the whole image. First-Row-Then-Column
%get time
tic;
encode_1D = dct(gray');
encode_1D = dct(encode_1D');
toc;
t1 = toc;
disp(t1);
subplot(3, 2, 3);
decode_1D = idct(encode_1D);
decode_1D = idct(decode_1D');
decode_1D = decode_1D';
decode_img_1D = mat2gray(decode_1D);
imshow(decode_img_1D)
title('1D-DCT')
imwrite(decode_img_1D, 'F:\Programming\多媒体\hw\Big1\2011011313_exp1\res_pics\exp1\lena1D-DCT.bmp');
%get PSNR
psnr1 = PSNR(gray , decode_1D);
disp(psnr1);

%2D-DCT on the whole image
%get time
tic;
encode_2D = dct2(gray);
toc;
t2 = toc;
disp(t2);
decode_2D = idct2(encode_2D);
decode_2D_img = mat2gray(decode_2D);
subplot(3, 2, 4);
imshow(decode_2D_img);
title('2D-DCT');
imwrite(decode_2D_img, 'F:\Programming\多媒体\hw\Big1\2011011313_exp1\res_pics\exp1\lena2D-DCT.bmp')
%get PSNR
psnr2 = PSNR(gray, decode_2D);
disp(psnr2);

%2D-DCT on 8*8 blocks
%get time
tic
blocks = mat2cell(gray, ones(512/8, 1)*8, ones(512/8, 1)*8);
for i = 1 : 1 : 512/8
    for j = 1 : 1 : 512/8
        temp{i, j} = dct2(blocks{i, j});
    end
end
encode_2D_blocks = cell2mat(temp);
toc;
t3 = toc;
disp(t3);
de_blocks = mat2cell(encode_2D_blocks, ones(512/8, 1)*8, ones(512/8, 1)*8);
for i = 1 : 1 : 512/8
    for j = 1 : 1 : 512/8
        de_temp{i, j} = idct2(de_blocks{i, j});
    end
end
decode_2D_blocks = cell2mat(de_temp);
decode_2D_blocks_img = mat2gray(decode_2D_blocks);
subplot(3, 2, 5);
imshow(decode_2D_blocks_img);
title('2D-DCT on 8*8 blocks');
imwrite(decode_2D_blocks_img, 'F:\Programming\多媒体\hw\Big1\2011011313_exp1\res_pics\exp1\lena2D-DCT_blocks.bmp');
%get psnr
psnr3 = PSNR(gray, decode_2D_blocks);
disp(psnr3);

figure();
%change with coefficients
%1D-DCT change
%1/4
ans1 = change_with_coeff( 1/4, encode_1D );
decode_1D_coeff4 = idct(ans1);
decode_1D_coeff4 = idct(decode_1D_coeff4');
decode_1D_coeff4 = decode_1D_coeff4';
decode_1D_coeff4_img = mat2gray(decode_1D_coeff4);
subplot(3, 3, 1);
imshow(decode_1D_coeff4_img);
title('1D-DCT with coefficient 1/4');
imwrite(decode_1D_coeff4_img, 'F:\Programming\多媒体\hw\Big1\2011011313_exp1\res_pics\exp1\lena1D-DCT_coeff4.bmp');
psnr4 = PSNR(gray, decode_1D_coeff4);
disp(psnr4);

%1/16
ans2 = change_with_coeff( 1/16, encode_1D );
decode_1D_coeff16 = idct(ans2);
decode_1D_coeff16 = idct(decode_1D_coeff16');
decode_1D_coeff16 = decode_1D_coeff16';
decode_1D_coeff16_img = mat2gray(decode_1D_coeff16);
subplot(3, 3, 2);
imshow(decode_1D_coeff16_img);
title('1D-DCT with coefficient 1/16');
imwrite(decode_1D_coeff16_img, 'F:\Programming\多媒体\hw\Big1\2011011313_exp1\res_pics\exp1\lena1D-DCT_coeff16.bmp');
psnr5 = PSNR(gray, decode_1D_coeff16);
disp(psnr5);

%1/64
ans3 = change_with_coeff( 1/64, encode_1D );
decode_1D_coeff64 = idct(ans3);
decode_1D_coeff64 = idct(decode_1D_coeff64');
decode_1D_coeff64 = decode_1D_coeff64';
decode_1D_coeff64_img = mat2gray(decode_1D_coeff64);
subplot(3, 3, 3);
imshow(decode_1D_coeff64_img);
title('1D-DCT with coefficient 1/64');
imwrite(decode_1D_coeff64_img, 'F:\Programming\多媒体\hw\Big1\2011011313_exp1\res_pics\exp1\lena1D-DCT_coeff64.bmp');
psnr6 = PSNR(gray, decode_1D_coeff64);
disp(psnr6);

%2D-DCT change
%1/4
ans4 = change_with_coeff( 1/4, encode_2D );
decode_2D_coeff4 = idct2(ans4);
decode_2D_coeff4_img = mat2gray(decode_2D_coeff4);
subplot(3, 3, 4);
imshow(decode_2D_coeff4_img);
title('2D-DCT with coefficient 1/4');
imwrite(decode_2D_coeff4_img, 'F:\Programming\多媒体\hw\Big1\2011011313_exp1\res_pics\exp1\lena2D-DCT_coeff4.bmp');
psnr7 = PSNR(gray, decode_2D_coeff4);
disp(psnr7);

%1/16
ans5 = change_with_coeff( 1/16, encode_2D );
decode_2D_coeff16 = idct2(ans5);
decode_2D_coeff16_img = mat2gray(decode_2D_coeff16);
subplot(3, 3, 5);
imshow(decode_2D_coeff16_img);
title('2D-DCT with coefficient 1/16');
imwrite(decode_2D_coeff16_img, 'F:\Programming\多媒体\hw\Big1\2011011313_exp1\res_pics\exp1\lena2D-DCT_coeff16.bmp');
psnr8 = PSNR(gray, decode_2D_coeff16);
disp(psnr8);

%1/64
ans6 = change_with_coeff( 1/64, encode_2D );
decode_2D_coeff64 = idct2(ans6);
decode_2D_coeff64_img = mat2gray(decode_2D_coeff64);
subplot(3, 3, 6);
imshow(decode_2D_coeff64_img);
title('2D-DCT with coefficient 1/64');
imwrite(decode_2D_coeff64_img, 'F:\Programming\多媒体\hw\Big1\2011011313_exp1\res_pics\exp1\lena2D-DCT_coeff64.bmp');
psnr9 = PSNR(gray, decode_2D_coeff64);
disp(psnr9);

%2D-DCT 8*8 blocks
%1/4
decode_2D_blocks_coeff4 = change_with_coeff_blocks(1/4, encode_2D_blocks);
decode_2D_blocks_coeff4_img = mat2gray(decode_2D_blocks_coeff4);
subplot(3, 3, 7);
imshow(decode_2D_blocks_coeff4_img);
title('2D-DCT blocks with coefficient 1/4');
imwrite(decode_2D_blocks_coeff4_img, 'F:\Programming\多媒体\hw\Big1\2011011313_exp1\res_pics\exp1\lena2D-DCT__blocks_coeff4.bmp');
psnr10 = PSNR(gray, decode_2D_blocks_coeff4);
disp(psnr10);

%1/16
decode_2D_blocks_coeff16 = change_with_coeff_blocks(1/16, encode_2D_blocks);
decode_2D_blocks_coeff16_img = mat2gray(decode_2D_blocks_coeff16);
subplot(3, 3, 8);
imshow(decode_2D_blocks_coeff16_img);
title('2D-DCT blocks with coefficient 1/16');
imwrite(decode_2D_blocks_coeff16_img, 'F:\Programming\多媒体\hw\Big1\2011011313_exp1\res_pics\exp1\lena2D-DCT__blocks_coeff16.bmp');
psnr11 = PSNR(gray, decode_2D_blocks_coeff16);
disp(psnr11);

%1/64
decode_2D_blocks_coeff64 = change_with_coeff_blocks(1/64, encode_2D_blocks);
decode_2D_blocks_coeff64_img = mat2gray(decode_2D_blocks_coeff64);
subplot(3, 3, 9);
imshow(decode_2D_blocks_coeff64_img);
title('2D-DCT blocks with coefficient 1/64');
imwrite(decode_2D_blocks_coeff64_img, 'F:\Programming\多媒体\hw\Big1\2011011313_exp1\res_pics\exp1\lena2D-DCT__blocks_coeff64.bmp');
psnr12 = PSNR(gray, decode_2D_blocks_coeff64);
disp(psnr12);

