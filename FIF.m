
function  [scalar_vector, stdmat] = FIF(iutD, goldD)
    
    scalar_vector = 0.1:0.1:2 ;
    scalar_length = length(scalar_vector) ; 
    stdmat = [] ;
    for i = 1:scalar_length
        diff = double(iutD.*scalar_vector(i)) - double(goldD) ; 
        stdmat = [stdmat, std(diff(:), 1)] ; 
%         diff_data(i).avg = mean(diff_data(i).diff(:)) ;
%         diff_data(i).sum = sum(diff_data(i).diff(:)) ; 
%         diff_data(i).mad = mad(diff_data(i).diff(:)) ; 
    end 
    
%     [diff_data(1).stdMinVal, diff_data(1).stdMinIdx] = min([diff_data.std]) ;
%     diff_data(1).stdIutD = std(double(diff_data(1).iutD(:))) ;
%     diff_data(1).madIutD = mad(double(diff_data(1).iutD(:))) ;
end