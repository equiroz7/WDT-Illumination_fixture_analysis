function run = WDT_loadData(start)

%% Choose data folder and find subfolders
run_dir = uigetdir(start,'Choose Data Folder') ; %Choose folder that contains the production runs you wish to analyze
cd(run_dir)
runStruct = dir('*Illum*') ;
runCell = {runStruct(:).name} ;
runCell_size = size(runCell) ;

%% Choose Calibration folder
start = 'C:\Users\equiroz\Google Drive\Projects\Western\Semrock Filters\images_matlab work\Fixture images\playground' ;
cal_dir = uigetdir(start,'Choose Calibration Folder') ; % Choose folder that contains the calibration files
cd(cal_dir) ;
iutBrightStruct = dir('*IUT_BRIGHT*.tif') ;
iutDarkStruct = dir('*IUT_DARK*.tif') ;
sideBrightStruct = dir('*SIDE_BRIGHT*.tif') ;
sideDarkStruct = dir('*SIDE_BRIGHT*.tif') ;

%% Load in calibration files
for j = 1:5
    iutBright(j).name = iutBrightStruct(j).name ;
    iutBright(j).img = imread([cal_dir, '\', iutBright(j).name]) ;
    
    iutDark(j).img = imread([cal_dir, '\', iutDarkStruct(j).name]) ;
    
%     sideBright(j).name = iutBrightStruct(j).name ;
%     sideBright(j).img = imread([cal_dir, '\', sideBrightStruct(j).name]) ;
%     fileNameSepAtLoc = strfind(sideBrightStruct(j).name, '_');
%     sideBright(j).LEDpwr = str2double(sideBright(j).name(fileNameSepAtLoc(end)+1:(end-4)));
    
%     sideDark(j).img = imread([cal_dir, '\', sideBrightStruct(j).name]) ;
    
    % Subtract dark and get image stats
    fileNameSepAtLoc = strfind(iutBright(j).name, '_');
    iutBright(j).LEDpwr = str2double(iutBright(j).name(fileNameSepAtLoc(end)+1:(end-4)));
    iutBright(j).imgD = iutBright(j).img - iutDark(j).img ;
    
end

%% Run img stats
for i = 1:runCell_size(2)
    cd([run_dir,'\', runCell{i}])
    iutStruct = dir('*IUT*.tif') ; % Get all .tif files in alphabetic order
    iutCell = {iutStruct(:).name} ;  % Get every other TIF (IUT.tif images)
    iutCell_size = size(iutCell) ;
    
    for k = 1:iutCell_size(2)
        run(i).iut(k).name = iutCell{k} ;
        run(i).iut(k).filename = [run_dir,'\', runCell{i},'\', run(i).iut(k).name] ;
        run(i).iut(k).img = imread(run(i).iut(k).filename) ;
        % Image stats
        run(i).iut(k).imgD = run(i).iut(k).img - iutDark(k).img ;
        run(i).iut(k).imgDAvg = mean2(run(i).iut(k).imgD) ;
        run(i).iut(k).imgDSTD = std(double(run(i).iut(k).imgD(:)), 1) ;
        
        %Parse out LED Power and add to struct
        fileNameSepAtLoc = strfind(run(i).iut(k).name, '_') ;
        run(i).iut(k).LEDpwr = str2double(run(i).iut(k).name(fileNameSepAtLoc(end)+1:(end-4)));
        
        % LED power scalar
        run(i).iut(k).LEDpwrScalar = iutBright(k).LEDpwr/run(i).iut(k).LEDpwr ;
        
        % Calc diff and div (Matches Mike's Algo v3.5
        run(i).iut(k).diff = double(run(i).iut(k).imgD.*run(i).iut(k).LEDpwrScalar)-double(iutBright(k).imgD) ; 
        run(i).iut(k).div = double(run(i).iut(k).imgD.*run(i).iut(k).LEDpwrScalar)./double(iutBright(k).imgD) ; 
        run(i).iut(k).div(isnan(run(i).iut(k).div(:))) = 1 ;
        run(i).iut(k).div(isinf(run(i).iut(k).div(:))) = 1 ;
        run(i).iut(k).diffAVG = mean(run(i).iut(k).diff(:)) ; 
        run(i).iut(k).divAVG = mean(run(i).iut(k).div(:)) ; 
        run(i).iut(k).diffSTD = std(run(i).iut(k).diff(:), 1) ;
        run(i).iut(k).divSTD = std(run(i).iut(k).div(:), 1) ;
        
        % Calc std(diff), std(div), 
        [run(i).iut(k).scalarVector, run(i).iut(k).STDdiff]  = FIF(run(i).iut(k).imgD, iutBright(k).imgD) ;
%         run(i).iut(k).stddiv = FIFdiv(run(i).iut(k).img, iutBright(k).img, iutDark(k).img) ;
        
        % Find objects in div image
        threshold = 1.0 ; 
        run(i).iut(k).imgBW = (run(i).iut(k).div > threshold);
        objects = regionprops(run(i).iut(k).imgBW, run(i).iut(k).div, 'Area', 'MeanIntensity', 'Centroid', 'MajorAxisLength');
        run(i).iut(k).objectAreas = [objects(:).Area] ;
        run(i).iut(k).objectMeanIntensities = [objects(:).MeanIntensity] ;
    end
    
    % iut(i).iutDAvg = mean2(iut(i).iutD) ;
    % [iut(i).sum, iut(i).avg, iut(i).std, iut(i).min, iut(i).max] = imgstat(iut(i).iut);
    
end