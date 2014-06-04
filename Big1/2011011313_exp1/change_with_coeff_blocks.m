function [ decode_In ] = change_with_coeff_blocks( coefficient, In )
    blocks = mat2cell(In, ones(512/8, 1)*8, ones(512/8, 1)*8);
    temp_coeff = 8 * sqrt(coefficient)
    for i = 1 : 1 : 512/8
        for j = 1 : 1 : 512/8
            for row = 1 : 1 : 8
                for col = 1 : 1 : 8
                    if row > temp_coeff || col > temp_coeff
                        blocks{i, j}(row, col) = 0;
                    end
                end
            end
            temp{i, j} = idct2(blocks{i, j});
        end
    end
    decode_In = cell2mat(temp);
end

