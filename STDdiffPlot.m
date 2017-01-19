%% Plot STD(div) of 5 channels of all runs
function fig = STDdiffPlot(run)

runCell_size = size(run) ; 
x = ones(1, runCell_size(2)) ;
legendStr = {'Blue', 'DeepRed', 'Green', 'IR', 'Red'} ; 
colorStr = {'bo', 'mo', 'go', 'ko', 'ro'} ; 

fig = figure() ;
hold on
for j = 1:5
STDdiff(j).y = [] ;
for i = 1:runCell_size(2)
    STDdiff(j).y = [STDdiff(j).y, run(i).iut(j).diffSTD] ;
    x(:) = j ;
    STDdiff(j).x = x ;
end
grid on
plot(STDdiff(j).x, STDdiff(j).y, colorStr{j}, 'LineWidth', 2)
end
title('STD(diff)')
ylabel('STD(diff)')
xlabel('Channel')
legend(legendStr)