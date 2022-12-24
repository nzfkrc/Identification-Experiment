trialnum = 0;
endpractice=0;
for trial = 1:20
     
     trialnum = trialnum+1;
    %Shuffle test clips for every movie.
     testcliporder= Shuffle(testcliporder,1);
     
     %Ask the question
     DrawFormattedText(window, sprintf('%s', practicekeysString(trialnum,3)), 'center', 'center', [0 0 0]);
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
        moviefile = dir(sprintf('C:\\Users\\Psikoloji Lab\\Desktop\\RSVP\\RSVP3\\practicemovie\\%s',practicekeysString(trialnum,4)));
        locationname = sprintf('C:\\Users\\Psikoloji Lab\\Desktop\\RSVP\\RSVP3\\practicemovie\\%s',practicekeysString(trialnum,4));
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
p.TrialDataLabels = {'ID' 'Age' 'Gender' 'EducationStatus' 'TrialOrder' 'ClipPositionInTheSequence' 'MovieType' 'MovieNumber' 'ClipNumber' 'MotionType' 'StimulusType' 'Accuracy' 'ReactionTime' 'VAI'};
p.TrialData(trialnum, 1) = {p.PARTID};
p.TrialData(trialnum, 2) = {p.Age};
p.TrialData(trialnum, 3) = {p.Gender};
p.TrialData(trialnum, 4) = {p.EducationStatus};
p.TrialData(trialnum, 5) = {trialnum};
p.TrialData(trialnum, 6) = {find(contains(clips, practicekeysString(trialnum,2)))}; %Clip's position in the sequence
%if sum(strcmp({convertStringsToChars(practicekeysString(trialnum,1))},blackandwhite)) == 1
if sum(strcmp(practicekeysString(trialnum,1),blackandwhite)) == 1
p.TrialData(trialnum, 7) = {1}; % black and white = 1
else
p.TrialData(trialnum, 7) = {2}; % coloured = 2
end
p.TrialData(trialnum, 8)= cellstr(practicekeysString(trialnum,1)); %Movie number
p.TrialData(trialnum, 9)= {clipname}; %Clip number
if practicekeysString(trialnum,6) == 'biological'
p.TrialData(trialnum, 10)= {1}; %BIOLOGICAL = 1
else
p.TrialData(trialnum, 10)= {2}; %NON-BIOLOGICAL = 2
end
if str2double(practicekeysString(trialnum,5)) == 1
p.TrialData(trialnum, 11)= {1}; %valid trial =  1 The clip asked is in the sequence
elseif str2double(practicekeysString(trialnum,5)) == 2
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
                       p.TrialData(trialnum, 13) = {sprintf('%.3f',1000*(secs-timeStart))};
                        if (keyCode(rightKey) && str2double(practicekeysString(trialnum,5)) == 1) 
                            p.TrialData(trialnum, 12)= {1}; %true1
                                correct=1;
                                correct_key = 'Evet (Sag Ok Tusu)';
                                msg = sprintf('%s cevabiniz dogru!',correct_key);
                        elseif (keyCode(leftKey) && str2double(practicekeysString(trialnum,5)) == 2)
                            p.TrialData(trialnum, 12)= {1}; %true2
                               correct=1;
                                correct_key = 'Hayir (Sol Ok Tusu)';
                                msg = sprintf('%s cevabiniz dogru!',correct_key);
                        elseif (keyCode(rightKey) && str2double(practicekeysString(trialnum,5)) == 2) 
                               p.TrialData(trialnum, 12)= {0}; %false1
                               correct=0;
                                correct_key = 'Hayir (Sol Ok Tusu)';
                                msg = sprintf('Cevabiniz yanlis.\nDogru cevap %s olacakti.',correct_key);
                        elseif (keyCode(leftKey) && str2double(practicekeysString(trialnum,5)) == 1)
                                 p.TrialData(trialnum, 12)= {0}; %false2
                                 correct=0;
                                 correct_key = 'Evet (Sag Ok Tusu)';
                                msg = sprintf('Cevabiniz yanlis.\nDogru cevap %s olacakti.',correct_key);
                        end
                                
                        break;
                    elseif keyCode(quitKey)
                        sca;
                        break;
                    else
                        keyIsDown=0;
                    end
                end
                        %toolbox doesnt let you open more than 100 movies, so this function
                        %closes all open movies and let us to play more.
                        Screen('CloseMovie');
                        
            end 
                    if correct == 0
                     textcolour = [1 0 0];
                    else 
                     textcolour = [0 1 0];
                    end
                    DrawFormattedText(window, msg, 'center', 'center', textcolour);
                    vbl = Screen('Flip', window);

       
if rem(trialnum,2) == 1
DrawFormattedText(window, 'Alistirma kisminda\nbir sonraki denemeye devam etmek icin lutfen “Enter” tusuna basin.', 'center', 'center', [0 0 0]);
end

%read frames and evaluate
                frames = mmread(sprintf('C:\\Users\\Psikoloji Lab\\Desktop\\RSVP\\RSVP3\\practicemovie\\%s\\%s.mov',practicekeysString(trialnum,4),practicekeysString(trialnum,2)));
                first_frames = frames.frames(1);
                first_frames = first_frames.cdata;
                last_frames = frames.frames(end);
                last_frames = last_frames.cdata;
                %frameVAI= corr2(rgb2gray(first_frames), rgb2gray(last_frames));

%p.TrialData(trialnum, 14)= {sprintf('%.3f',frameVAI)};
KbReleaseWait;
if rem(trialnum,2) == 1
Screen('Flip', window, vbl + 2);
end
              
            while rem(trialnum,2) == 1
                  [keyIsDown, secs, keyCode] = KbCheck;
                    if keyIsDown && sum(keyCode) == 1
                        if keyCode(enterKey)
                            break;
                        else
                            keyIsDown=0;
                        end
                    end
            end
              
            if rem(trialnum,2) == 0
              practicekeysString = Shuffle(practicekeysString,2);
              DrawFormattedText(window, 'Tekrar deneme yapmak icin "space" tusuna,\n\nGercek deneye gecmek icin lütfen "enter" tusuna basin.', 'center', 'center', [0 0 0]);
              Screen('Flip', window, vbl + 2);

            keyIsDown=0;            
            while 1 
                  [keyIsDown, secs, keyCode] = KbCheck;
                    if keyIsDown && sum(keyCode) == 1
                        if keyCode(startKey)
                           trialnum = 0;
                           counting =0;
                            break;
                        elseif keyCode(enterKey)
                            endpractice = 1;   
                         break;
                            
                        else
                            keyIsDown=0;
                        end
                    end
            end
            end

if endpractice == 1
    break;
end
              
end