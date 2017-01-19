
function fig = WDTplotSTD(channel, run)
runCell_size = size(run) ; 
runMat = 1:runCell_size(2) ; 

if channel == 1
    channelName = 'Blue' ;
elseif channel == 2
    channelName = 'DeepRed' ;
elseif channel == 3
    channelName = 'Green' ;
elseif channel == 4
    channelName = 'IR' ;
elseif channel == 5
    channelName = 'Red' ;
else
end

fig = figure() ;
hold on
legendCell = {} ;
every3_1 = runMat(1:3:end) ;
every3_2 = runMat(2:3:end) ;
every3_3 = runMat(3:3:end) ;

for r = runMat
    every3_1_logic = sum((every3_1 == r)) ;
    every3_2_logic = sum((every3_2 == r)) ;
    every3_3_logic = sum((every3_3 == r)) ;
    if every3_1_logic
        lineShape = '-' ;
    elseif every3_2_logic
        lineShape = '--' ;
    elseif every3_3_logic
        lineShape = '-.' ;
    else
    end
    plot(run(r).iut(channel).scalarVector, run(r).iut(channel).STDdiff, lineShape, 'lineWidth', 2) ;
    legendCell{end+1} = ['run ', num2str(r)] ;
end
legend(legendCell, 'Location','SouthEast')

% plot(diff_data_A(1).scalarVector, [diff_data_A.std])
axis([0.2 1.8 0 2500])
grid on
grid minor
xlabel('scalar')
ylabel('min std(diff)')
title([channelName, ': std(diff)'])

output = 0 ;

end

