function fig = WDTanalysis()

plot = choosedialog ; 

start = 'C:\Users' ;
[run] = WDT_loadData(start) ;
if strcmp(plot,'std(diff)')
    fig = STDdiffPlot(run) ;
elseif strcmp(plot,'avg(diff)')
    fig = AVGdivPlot(run) ;
elseif strcmp(plot,'std(div)')
    fig = STDdivPlot(run) ;
elseif strcmp(plot,'avg(div)')
    fig = STDdivPlot(run) ;
elseif strcmp(plot,'Calc std(diff)')
    for channel = 1:5
        fig(channel).figure = WDTplotSTD(channel, run) ;
    end
else
    disp('no plot') ; 
end


function choice = choosedialog

    d = dialog('Position',[300 300 250 150],'Name','Select Analysis Plot');
    txt = uicontrol('Parent',d,...
           'Style','text',...
           'Position',[20 80 210 40],...
           'String','Select a color');
       
    popup = uicontrol('Parent',d,...
           'Style','popup',...
           'Position',[75 70 100 25],...
           'String',{'std(diff)';'avg(diff)';'std(div)'; 'avg(div)'; 'Calc std(diff)'},...
           'Callback',@popup_callback);
       
    btn = uicontrol('Parent',d,...
           'Position',[89 20 70 25],...
           'String','Select',...
           'Callback','delete(gcf)');
       
    choice = 'Calc std(diff)';
       
    % Wait for d to close before running to completion
    uiwait(d);
   
       function popup_callback(popup,event)
          idx = popup.Value;
          popup_items = popup.String;
          % This code uses dot notation to get properties.
          % Dot notation runs in R2014b and later.
          % For R2014a and earlier:
          % idx = get(popup,'Value');
          % popup_items = get(popup,'String');
          choice = char(popup_items(idx,:));
       end
   
end

end