%% Plot AVG(div) of 5 channels of all runs
function fig = AVGdivPlot(run)

runCell_size = size(run) ;
x = ones(1, runCell_size(2)) ;
legendStr = {'Blue', 'DeepRed', 'Green', 'IR', 'Red'} ; 
colorStr = {'bo', 'mo', 'go', 'ko', 'ro'} ; 

fig = figure() ;
hold on
for j = 1:5
AVGdiv(j).y = [] ;
for i = 1:runCell_size(2)
    AVGdiv(j).y = [AVGdiv(j).y, run(i).iut(j).divAVG] ;
    x(:) = j ;
    AVGdiv(j).x = x ;
end
grid on
plot(AVGdiv(j).x, AVGdiv(j).y, colorStr{j}, 'LineWidth', 2)
end
title('AVG(div)')
ylabel('AVG(div)')
xlabel('Channel')
legend(legendStr, 'Location','SouthWest') 
