function micSig = addRec(M, y, fs, c, d, R, inputTheta)
% Record your voice for 5 seconds.
recObj = audiorecorder(fs, 16, 1);
disp('Start speaking.')
recordblocking(recObj, 2);
disp('End of Recording.');

% Play back the recording.
play(recObj);

% Store data in double-precision array.
myRecording = getaudiodata(recObj);
figure
t = 1:length(myRecording);
plot(t/fs,myRecording)
title(['Input Theta: ' int2str(inputTheta)])

micSig = y + micArrayRec(M, fs, myRecording, c, R, d, inputTheta);
    
end