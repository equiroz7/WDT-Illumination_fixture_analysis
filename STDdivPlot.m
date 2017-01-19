%% Plot STD(div) of 5 channels of all runs
function fig = STDdivPlot(run)

runCell_size = size(run) ; 
x = ones(1, runCell_size(2)) ;
legendStr = {'Blue', 'DeepRed', 'Green', 'IR', 'Red'} ; 
colorStr = {'bo', 'mo', 'go', 'ko', 'ro'} ; 

fig = figure() ;
hold on
for j = 1:5
STDdiv(j).y = [] ;
for i = 1:runCell_size(2)
    STDdiv(j).y = [STDdiv(j).y, run(i).iut(j).divSTD] ;
    x(:) = j ;
    STDdiv(j).x = x ;
end
grid on
plot(STDdiv(j).x, STDdiv(j).y, colorStr{j}, 'LineWidth', 2)
end
title('STD(div)')
ylabel('STD(div)')
xlabel('Channel')
legend(legendStr) 

