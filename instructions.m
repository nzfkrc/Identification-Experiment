KbReleaseWait;
instruction = 1;

[~, ny, textbounds1, ~] = DrawFormattedText(window, 'Yonergeler (1/3)\n\nBu kisim bir deneme kismidir.\nDeneye hazir olmaniz icin tasarlanmistir.\nBurada yapmaniz gereken sey\ndeney sirasinda yapmaniz gerekenle aynidir.', 'center', 'center', [1 1 1]);
[~, ~, textbounds2, ~] = DrawFormattedText(window, '\nYonergeler arasinda gezinmek icin yon tuslarini kullanabilirsiniz.', 'center', ny+2*TextSize, [1 1 1]);


textbounds(1) = 2*fix((2*xCenter-textbounds2(3)-TextSize/2)/2); %leftborder
textbounds(2) = 2*fix((textbounds1(2)-TextSize/2)/2); %topborder
textbounds(3) = 2*fix((textbounds2(3)+TextSize)/2); %rightborder
textbounds(4) = 2*(fix((textbounds2(4)+TextSize/2)/2)-fix(TextSize/2)); %bottomborder

textbounds=CenterRectOnPointd(textbounds, xCenter, yCenter);
Screen('FillRect', window, [1 1 0], textbounds);
[~, ny, ~, ~] = DrawFormattedText(window, 'Yonergeler (1/3)\n\nBu kisim bir deneme kismidir.\nDeneye hazir olmaniz icin tasarlanmistir.\nBurada yapmaniz gereken sey\ndeney sirasinda yapmaniz gerekenle aynidir.', textbounds(1)+TextSize, textbounds(2)+TextSize, [0 0 0]);
[~, ~, ~, ~] = DrawFormattedText(window, '\nYonergeler arasinda gezinmek icin yon tuslarini kullanabilirsiniz.', textbounds(1)+TextSize, ny+1.5*TextSize, [1 0 0]);
KbReleaseWait;
Screen('Flip', window);

while 1
[keyIsDown, ~, keyCode] = KbCheck;
if keyIsDown && sum(keyCode(backforwardKeys(2))) == 1
break;
end
end


while 1
KbReleaseWait;
 if keyIsDown && sum(keyCode(backforwardKeys(1))) == 1
    if instruction > 1
        instruction = instruction-1;
    end
 end
 if keyIsDown && sum(keyCode(backforwardKeys(2))) == 1
    if instruction < 3
        instruction = instruction+1;
    end
 end
 if keyIsDown && sum(keyCode(enterKey)) == 1
    if instruction == 3
        break;
    end
 end

keyIsDown=0;
if instruction == 1
[~, ny, textbounds1, ~] = DrawFormattedText(window, 'Yonergeler (1/3)\n\nBu kisim bir deneme kismidir.\nDeneye hazir olmaniz icin tasarlanmistir.\nBurada yapmaniz gereken sey\ndeney sirasinda yapmaniz gerekenle aynidir.', 'center', 'center', [1 1 1]);
[~, ~, textbounds2, ~] = DrawFormattedText(window, '\nYonergeler arasinda gezinmek icin yon tuslarini kullanabilirsiniz.', 'center', ny+2*TextSize, [1 1 1]);


textbounds(1) = 2*fix((2*xCenter-textbounds2(3)-TextSize/2)/2); %leftborder
textbounds(2) = 2*fix((textbounds1(2)-TextSize/2)/2); %topborder
textbounds(3) = 2*fix((textbounds2(3)+TextSize)/2); %rightborder
textbounds(4) = 2*(fix((textbounds2(4)+TextSize/2)/2)-fix(TextSize/2)); %bottomborder

textbounds=CenterRectOnPointd(textbounds, xCenter, yCenter);
Screen('FillRect', window, [1 1 0], textbounds);
[~, ny, ~, ~] = DrawFormattedText(window, 'Yonergeler (1/3)\n\nBu kisim bir deneme kismidir.\nDeneye hazir olmaniz icin tasarlanmistir.\nBurada yapmaniz gereken sey\ndeney sirasinda yapmaniz gerekenle aynidir.', textbounds(1)+TextSize, textbounds(2)+TextSize, [0 0 0]);
[~, ~, ~, ~] = DrawFormattedText(window, '\nYonergeler arasinda gezinmek icin yon tuslarini kullanabilirsiniz.', textbounds(1)+TextSize, ny+1.5*TextSize, [1 0 0]);
KbReleaseWait;
Screen('Flip', window);
end

if instruction == 2

   [~, ny, textbounds1, ~] = DrawFormattedText(window, 'Yonergeler (2/3)\n\nEkranda ilk once bir hareketin ismi yazacak.\n5 saniye sonra bir arti isareti (+) belirecek.\nArdindan ise 5 klip art arda oynatilacak.\nGoreviniz, ekranda yazan hareketin bu 5 klip icerisinde olup olmadigini\nsaptamaktir. 5 klip oynatildiktan hemen sonra eger o hareketi\ngormusseniz "sag yon" tusunu,\ngormemisseniz "sol yon" tusunu kullanmaniz gerekmektedir.', 'center', 'center', [1 1 1]);
   [~, ~, textbounds2, ~] = DrawFormattedText(window, '\nYonergeler arasinda gezinmek icin yon tuslarini kullanabilirsiniz.', 'center', ny+2*TextSize, [1 1 1]);


textbounds(1) = 2*fix((2*xCenter-textbounds2(3)-TextSize/2)/2); %leftborder
textbounds(2) = 2*fix((textbounds1(2)-TextSize/2)/2); %topborder
textbounds(3) = 2*fix((textbounds1(3)+TextSize)/2+TextSize); %rightborder
textbounds(4) = 2*(fix((textbounds2(4)+TextSize/2)/2)-fix(TextSize/2)); %bottomborder

textbounds=CenterRectOnPointd(textbounds, xCenter, yCenter);
Screen('FillRect', window, [1 1 0], textbounds);
[~, ny, ~, ~] = DrawFormattedText(window, 'Yonergeler (2/3)\n\nEkranda ilk once bir hareketin ismi yazacak.\n5 saniye sonra bir arti isareti (+) belirecek.\nArdindan ise 5 klip art arda oynatilacak.\nGoreviniz, ekranda yazan hareketin bu 5 klip icerisinde olup olmadigini\nsaptamaktir. 5 klip oynatildiktan hemen sonra eger o hareketi\ngormusseniz "sag yon" tusunu,\ngormemisseniz "sol yon" tusunu kullanmaniz gerekmektedir.', textbounds(1)+TextSize, textbounds(2)+TextSize, [0 0 0]);
[~, ~, ~, ~] = DrawFormattedText(window, '\nYonergeler arasinda gezinmek icin yon tuslarini kullanabilirsiniz.', textbounds(1)+TextSize, ny+1.5*TextSize, [1 0 0]);
KbReleaseWait;
Screen('Flip', window);
end

if instruction == 3

[~, ny, textbounds1, ~] = DrawFormattedText(window, 'Yonergeler (3/3)\n\nUnutmayin: ilk once hareketin ne oldugu yazacak,\ndaha sonra 5 klip oynatilip, bu beslinin o hareketi icerip icermedigi sorulacak.\n\nVerdiginiz cevabin dogrulugu kadar cevap verme hiziniz da onemlidir.\nBu yuzden olabildigince hizli cevap vermeniz gerekmektedir.', 'center', 'center', [1 1 1]);
[~, ~, textbounds2, ~] = DrawFormattedText(window, 'Denemeye gecmek icin lutfen', 'center', ny+2*TextSize, [1 1 1]);
[~, ~, ~, ~] = DrawFormattedText(window, '"enter"', textbounds2(3)+TextSize/2.5, ny+2*TextSize, [1 1 1]);
[~, ky, ~, ~] = DrawFormattedText(window, 'tusuna basiniz.', textbounds2(3)+TextSize/2.5, ny+2*TextSize, [1 1 1]);
[~, ~, textbounds6, ~] = DrawFormattedText(window, '\nYonergeler arasinda gezinmek icin yon tuslarini kullanabilirsiniz.', 'center', ky+.5*TextSize, [1 1 1]);

textbounds(1) = 2*fix((2*xCenter-textbounds1(3)-TextSize/2)/2); %leftborder
textbounds(2) = 2*fix((textbounds1(2)-TextSize/2)/2); %topborder
textbounds(3) = 2*fix((textbounds1(3)+TextSize)/2); %rightborder
textbounds(4) = 2*(fix((textbounds6(4)+TextSize/2)/2)-fix(TextSize/2)); %bottomborder

textbounds=CenterRectOnPointd(textbounds, xCenter, yCenter);
Screen('FillRect', window, [1 1 0], textbounds);
[~, ny, ~, ~] = DrawFormattedText(window, 'Yonergeler (3/3)\n\nUnutmayin: ilk once hareketin ne oldugu yazacak,\ndaha sonra 5 klip oynatilip, bu beslinin o hareketi icerip icermedigi sorulacak.\n\nVerdiginiz cevabin dogrulugu kadar cevap verme hiziniz da onemlidir.\nBu yuzden olabildigince hizli cevap vermeniz gerekmektedir.', textbounds(1)+TextSize, textbounds(2)+TextSize, [0 0 0]);
[nx, ~, textbounds2, ~] = DrawFormattedText(window, 'Denemeye gecmek icin lutfen', textbounds(1)+TextSize, ny+2*TextSize, [0 0 0]);
[zx, ~, textbounds3, ~] = DrawFormattedText(window, '"enter"', textbounds2(3)+TextSize/2.5, ny+2*TextSize, [1 0 0]);
[~, ky, textbounds5, ~] = DrawFormattedText(window, 'tusuna basiniz.', textbounds3(3)+TextSize/2.5, ny+2*TextSize, [0 0 0]);
[~, ~, ~, ~] = DrawFormattedText(window, '\nYonergeler arasinda gezinmek icin yon tuslarini kullanabilirsiniz.', textbounds(1)+TextSize, ky, [1 0 0]);
KbReleaseWait;
Screen('Flip', window);
end

while 1
[keyIsDown, ~, keyCode] = KbCheck;
if keyIsDown && ((sum(keyCode(backforwardKeys)))+sum(keyCode(enterKey))) == 1
break
end
end

end
