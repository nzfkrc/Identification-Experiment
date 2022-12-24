p.PARTID = '';
p.Age = '';
p.EducationStatus = '';
p.Gender = '';
p.Lecture = '';
p.SchoolNumber = '';
indx = [];
indx2 = [];
indxl = [];
genderlist = {'Kadin','Erkek'};
lectureList = {'PSYC 1101 - General Psychology', 'PSYC 3350 - Sensation and Perception', 'PSYC 5521 - Advanced Cognitive Psychology' 'PSYC 4055 - Theories of Psychotheraphy' 'PSYC 3330 - Personality Psychology' 'PSYC 0110 - Introduction to Social Psychology' 'PSYC 4310 - Industrial and Organizational Psychology' 'Gastronomi'};
edulist = {'Ilkokul','Ortaokul','Lise','Universite','Yuksek Lisans','Doktora'};

while isempty(p.PARTID) 
    answr = inputdlg('Katilimci numarasi','Participant ID');
    if isempty(answr) ~= 1
        p.PARTID = answr{1};
    end
end

while isempty(p.SchoolNumber) 
    answr1 = inputdlg('Ogrenci numaranizi giriniz','Ogrenci Numarasi');
    if isempty(answr1) ~= 1
        p.SchoolNumber = answr1{1};
    end
end

while isempty(indxl)
    [indxl,tf2] = listdlg('PromptString',{'Almakta oldugunuz dersi seciniz:'},'SelectionMode','single','ListString',lectureList);
    %if tf2 ~= 0
    p.Lecture = lectureList{indxl};
end

while isempty(p.Age)
    answr2 = inputdlg('Yasinizi giriniz','Yas');
    if isempty(answr2) ~= 1
    p.Age = answr2{1};
    end
end

while isempty(indx2)
    [indx2,tf2] = listdlg('PromptString',{'Cinsiyetinizi seciniz:'},'SelectionMode','single','ListString',genderlist);
    %if tf2 ~= 0
    p.Gender = genderlist{indx2};
end


while isempty(indx)
    [indx,tf] = listdlg('PromptString',{'Egitim durumunuzu seciniz:'},'SelectionMode','single','ListString',edulist);
    %if tf ~= 0
    p.EducationStatus = edulist{indx};
end


outputname = [p.PARTID '-' 'RSVP3' '-' datestr(now,30) '.mat'];

HideCursor;

PsychDefaultSetup(2);
Screen('Preference', 'SkipSyncTests', 0);
Screen('Preference', 'TextAlphaBlending', 1);
Screen('Preference', 'TextRenderer', 1);
Screen('Preference','VisualDebugLevel',0);
Screen('Preference','SuppressAllWarnings',1);

screens = Screen('Screens');
screenNumber = max(screens);

black = BlackIndex(screenNumber);
white = WhiteIndex(screenNumber);
grey = white/2;

[window, ~] = PsychImaging('OpenWindow', screenNumber, white, windowRect);
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

[p.screenXpixels, p.screenYpixels] = Screen('WindowSize', window);
[xCenter, yCenter] = RectCenter(windowRect);
p.numRect = 1;
p.RectSize = fix(windowRect(4)/8);
lineWidthPix = ceil(p.RectSize/33);
TextSize = 2*fix(windowRect(4)/70);
fixCrossDimPix = fix(p.RectSize/4);
RectColour = [0.5 0.5 0.5];
RectColours = repmat(RectColour',1,p.numRect);
centeredRect = CenterRectOnPointd([0 0 p.RectSize*2.3/2 p.RectSize*2.3/2], xCenter, yCenter);
centeredRect2 = CenterRectOnPointd([0 0 p.RectSize*4/5 p.RectSize*4/5], xCenter, yCenter);

RectSizeInCm=2;
height = (8.7+4)*p.RectSize/RectSizeInCm; 
width =  (8+4)*p.RectSize/RectSizeInCm; 

CoveringRectangle = CenterRectOnPointd([0 0 width height], xCenter, yCenter);



%BUTTONS 
KbName('UnifyKeyNames');
ResponseKeys = [KbName('RightArrow'), KbName('LeftArrow'), KbName('Space'), KbName('q'), KbName('Return'),KbName('q')];
quitKey = KbName('q');
startKey = KbName('Space');
leftKey = KbName('LeftArrow');
rightKey = KbName('RightArrow');
enterKey = KbName('Return');
p.ResponseKeyss = [KbName('LeftArrow'), KbName('RightArrow'), KbName('Space'), KbName('Return'),KbName('q')];
backforwardKeys = [KbName('LeftArrow'), KbName('RightArrow')];
RestrictKeysForKbCheck([ResponseKeys startKey quitKey]);

%START SCREEN
vbl = 0;
Screen('TextSize', window, TextSize);
DrawFormattedText(window, 'Ilk denemeye baslamak icin lutfen "space" tusuna basin.', 'center', 'center', [0 0 0]);
Screen('Flip', window, vbl + .3);

%BASLAMAK ICIN ONAY
keyIsDown=0;
while 1
[keyIsDown, ~, keyCode] = KbCheck;
         if keyIsDown && sum(keyCode(startKey)) == 1
            break;
         else
            keyIsDown=0;
         end 
end

%Movies
coloured = ['movie0032'; 'movie0041'; 'movie0044'; 'movie0048'; 'movie0049'; 'movie0020'; 'movie0079'; 'movie0102' ;'movie0111'; 'movie0120'];
blackandwhite  = ['movie0007'; 'movie0016'; 'movie0026'; 'movie0030'; 'movie0045'; 'movie0001'; 'movie0004'; 'movie0006'; 'movie0013'; 'movie0018'];


testcliporder = [3 4 5 6 7];


images = {'TheImage'};
counting = 0;

[~,keys] = xlsread('keys.xlsx','A1:F80');
keysString = string(keys);

[~,keys] = xlsread('practicekeys.xlsx','A1:F2');
practicekeysString = string(keys);

a = keysString;
b = string(blackandwhite);
c = string(coloured);

onlyblackandwhites = ismember(a,b);
onlycoloureds = ismember(a,c);
onlyblackandwhites = a(onlyblackandwhites(:,1)==1,:);
onlycoloureds = a(onlycoloureds(:,1)==1,:);

if movietype == 1
keysString = onlyblackandwhites;
allmovies= blackandwhite;
elseif movietype == 2
keysString = onlycoloureds;
allmovies = coloured;
else
allmovies = [blackandwhite;coloured];
end

movie_number = size(allmovies,1);
%keysString = Shuffle(keysString,2);