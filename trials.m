trialnum = 0;
for trial = 1:movie_number*4
   
     trialnum = trialnum+1;  
    %Shuffle test clips for every movie.
     testcliporder= Shuffle(testcliporder,1);
    
     %Ask the question
     DrawFormattedText(window, sprintf('%s', keysString(trial,3)), 'center', 'center', [0 0 0]);
     vbl = Screen('Flip', window);

     %Show the fixation cross
     allCoords = [-fixCrossDimPix fixCrossDimPix 0 0; 0 0 -fixCrossDimPix fixCrossDimPix];
     Screen('DrawLines', window, allCoords, lineWidthPix, grey, [xCenter yCenter], 2);
     vbl = Screen('Flip',window, vbl + 5);
     vbl = Screen('Flip',window, vbl + .2);
     % 5 clips will be presented repeatedly.
     while 1
        if counting ~= 5 
        counting = counting + 1;
        moviefile = dir(sprintf('C:\\Users\\Psikoloji Lab\\Desktop\\RSVP\\RSVP3\\%s\\%s', keysString(trial,1),keysString(trial,4)));
        locationname = sprintf('C:\\Users\\Psikoloji Lab\\Desktop\\RSVP\\RSVP3\\%s\\%s', keysString(trial,1),keysString(trial,4));
        clipname = moviefile(testcliporder(1,counting)).name;
        clips(counting,1) = {clipname};
        necessarycombine = strcat(locationname, '\', clipname);
    
        playing_clips = Screen('OpenMovie', window, necessarycombine);            
        Screen('PlayMovie', playing_clips, 1);
        
        %Show the movie clip.
        
           while 1
           % Wait for next movie frame, retrieve texture handle to it
           tex = Screen('GetMovieImage', window, playing_clips);
           % Valid texture returned? A negative value means end of movie reached:
           if tex<=0
                % We're done, break out of loop:
               break;
           end
            % Draw the new texture immediately to screen:
            Screen('DrawTexture', window, tex);
            % Update display:
            Screen('Flip', window);
            % Release texture:
            Screen('Close', tex);
            %end
           end
           
        else
            theImage = imread('TheImage.jpg');
            %Create a texture with the image
            imageTexture = Screen('MakeTexture',window, theImage);
            %Draw the texture
            Screen('DrawTexture', window, imageTexture);
            vbl = Screen('Flip', window);
            
            vbl = Screen('Flip', window, vbl + .4);

counting = 0;
break;
        end

     end
p.TrialDataLabels = {'ID' 'Age' 'Gender' 'EducationStatus' 'TrialOrder' 'ClipPositionInTheSequence' 'MovieType 1:blackandwhite, 2:coloured' 'MovieNumber' 'ClipNumber' 'MotionType 1:biological, 2:non-biological' 'StimulusType 1:target exists, 2:target doesn''t exist' 'Accuracy 1:true, 0:false' 'ButtonPressed 1:right, 2:left' 'ReactionTime' 'ExperimentNo' 'StudentNumber' 'Lecture'};
p.TrialData(trialnum, 1) = {p.PARTID};
p.TrialData(trialnum, 2) = {p.Age};
p.TrialData(trialnum, 3) = {p.Gender};
p.TrialData(trialnum, 4) = {p.EducationStatus};
p.TrialData(trialnum, 5) = {trialnum};
p.TrialData(trialnum, 6) = {find(contains(clips, keysString(trialnum,2)))}; %Clip's position in the sequence
%if sum(strcmp({convertStringsToChars(keysString(trialnum,1))},blackandwhite)) == 1
if sum(strcmp(keysString(trialnum,1),blackandwhite)) == 1
p.TrialData(trialnum, 7) = {1}; % black and white = 1
else
p.TrialData(trialnum, 7) = {2}; % coloured = 2
end
p.TrialData(trialnum, 8)= cellstr(keysString(trialnum,1)); %Movie number
p.TrialData(trialnum, 15)= {'3'};
p.TrialData(trialnum, 16)= {p.SchoolNumber};
p.TrialData(trialnum, 17)= {p.Lecture};
p.TrialData(trialnum, 9)= {clipname}; %Clip number

if keysString(trialnum,6) == 'biological'
p.TrialData(trialnum, 10)= {1}; %BIOLOGICAL = 1
else
p.TrialData(trialnum, 10)= {2}; %NON-BIOLOGICAL = 2
end
if str2double(keysString(trial,5)) == 1
p.TrialData(trialnum, 11)= {1}; %valid trial =  1 The clip asked is in the sequence
p.TrialData(trialnum, 9)= {clipname}; %Clip number
elseif str2double(keysString(trial,5)) == 2
p.TrialData(trialnum, 9)= {'no clip'}; %The motion asked does not exist in any clip
p.TrialData(trialnum, 11)= {2}; %invalid trial =  2 The clip asked is not in the sequence
end
            Screen('Flip', window, vbl + 1);
            
            DrawFormattedText(window, 'HAYIR ise SOL OK''a,      EVET ise SAG OK''a\n\nbasin.', 'center', 'center', [0 0 0])
            Screen('Flip', window);
          keyIsDown=0;
          timeStart = GetSecs;
            while 1
              [keyIsDown, secs, keyCode] = KbCheck;
                if keyIsDown && sum(keyCode) == 1
                    if keyCode(leftKey)|| keyCode(rightKey)
                       p.TrialData(trialnum, 14) = {sprintf('%.3f',1000*(secs-timeStart))};
                        if (keyCode(rightKey) && str2double(keysString(trial,5)) == 1) || (keyCode(leftKey) && str2double(keysString(trial,5)) == 2)
                            p.TrialData(trialnum, 12)= {1}; %true
                        else
                            p.TrialData(trialnum, 12)= {0}; %false
                        end
                        if keyCode(rightKey)
                           p.TrialData(trialnum, 13) = {1}; %Pressed right and said yes, it exists
                        elseif keyCode(leftKey)
                           p.TrialData(trialnum, 13) = {2}; %Pressed left and said no, it does not exist
                        end
                        break;
                    elseif keyCode(quitKey)
                        sca;
                        break;
                    else
                        keyIsDown=0;
                    end
                end
            end 

%toolbox doesnt let you open more than 100 movies, so this function
       %closes all open movies and let us to play more.
       Screen('CloseMovie');
if trialnum<movie_number*4
DrawFormattedText(window, 'Bir sonraki denemeye devam etmek icin lutfen “Enter” tusuna basin.', 'center', 'center', [0 0 0]);
end

%read frames and evaluate for the Target
                frames = mmread(sprintf('C:\\Users\\Psikoloji Lab\\Desktop\\RSVP\\RSVP3\\%s\\%s\\%s.mov', keysString(trial,1),keysString(trial,4),keysString(trial,2)));
                first_frames = frames.frames(1);
                first_frames = first_frames.cdata;
                last_frames = frames.frames(end);
                last_frames = last_frames.cdata;
                %frameVAI= corr2(rgb2gray(first_frames), rgb2gray(last_frames));
%if str2double(keysString(trial,5)) == 1
%p.TrialData(trialnum, 15)= {sprintf('%.3f',frameVAI)};
%else
%p.TrialData(trialnum, 15)= {'no clip'};
%end

%read frames and evaluate for the sequence
                averageVAI = 0;
                sequence = 0;
                for sequence = 1:5
                    oreo = moviefile(testcliporder(1,sequence)).name;
                frames = mmread(sprintf('C:\\Users\\Psikoloji Lab\\Desktop\\RSVP\\RSVP3\\%s\\%s\\%s', keysString(trial,1),keysString(trial,4),oreo)); %s.mov
                first_frames = frames.frames(1);
                first_frames = first_frames.cdata;
                last_frames = frames.frames(end);
                last_frames = last_frames.cdata;
                %frameVAI= corr2(rgb2gray(first_frames), rgb2gray(last_frames));
                %averageVAI(1, sequence) = frameVAI;
                end
                %averageVAI = mean(averageVAI);
                %p.TrialData(trialnum, 16)= {sprintf('%.3f',averageVAI)};

KbReleaseWait;
if trialnum<movie_number*4
Screen('Flip', window);
end
              
            while trialnum<movie_number*4
                  [keyIsDown, secs, keyCode] = KbCheck;
                    if keyIsDown && sum(keyCode) == 1
                        if keyCode(enterKey)
                            break;
                        else
                            keyIsDown=0;
                        end
                    end
            end
            
  

end
     
       

vbl = Screen('Flip', window);
              
DrawFormattedText(window, 'Deney bitmistir.\nKatiliminiz icin tesekkür ederiz.', 'center', 'center', [0 0 0]);
vbl = Screen('Flip', window, vbl + .500);
WaitSecs(2);

%convert .mat file to .xls file, and save to specified file location
folder2 = 'C:/Users/Psikoloji Lab/Desktop/RSVP/RSVP3/RMatFiles';
fullFileName2 = fullfile(folder2, outputname);

if ~exist(folder2, 'dir')
    mkdir(folder2);
end

save(fullFileName2,'p');

loaded = load(fullFileName2);
S = outputname;
S = S(1:end-4);

folder = 'C:/Users/Psikoloji Lab/Desktop/RSVP/RSVP3/Results';
if ~exist(folder, 'dir')
    mkdir(folder);
end
fullFileName = fullfile(folder, sprintf('%s.xls', S));

xlswrite(fullFileName,loaded.p.TrialDataLabels,1,'A1');
xlswrite(fullFileName,loaded.p.TrialData,1,'A2');

Screen('CloseAll');
sca;