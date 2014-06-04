function [ res_In ] = change_with_coeff( coefficient, In )
    temp_coeff = 512 * sqrt(coefficient);
    for i = 1 : 512 
        for j = 1 : 512
            if i > temp_coeff || j > temp_coeff
                In(i, j) = 0;
            end
            res_In(i, j) = In(i, j);
        end
    end
end

