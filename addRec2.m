function micSig = addRec2(M, y, fs, c, d, inputTheta, time)
% Record your voice for 5 seconds.
recObj = audiorecorder(fs, 16, 1);
disp('Start speaking.')
recordblocking(recObj, time);
disp('End of Recording.');

% Play back the recording.
play(recObj);

% Store data in double-precision array.
myRecording = getaudiodata(recObj);
% figure
% t = 1:length(myRecording);
% plot(t/fs,myRecording)
% title(['Input Theta: ' int2str(inputTheta)])

micSig = micArrayRec2(M, fs, y, myRecording, c, d, inputTheta);
    
end