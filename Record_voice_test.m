% Record your voice for 5 seconds.
fs = 20000;

recObj = audiorecorder(fs, 16, 1);
disp('Start speaking.')
recordblocking(recObj, 5);
disp('End of Recording.');

% Play back the recording.
play(recObj);

% Store data in double-precision array.
myRecording3 = getaudiodata(recObj);

% % Plot the waveform.
% plot(myRecording1);
% 
% pause(2)
% 
% % Record your voice for 5 seconds.
% recObj = audiorecorder(fs, 16, 1);
% disp('Start speaking.')
% recordblocking(recObj, 2);
% disp('End of Recording.');
% 
% % Play back the recording.
% play(recObj)
% 
% % Store data in double-precision array.
% myRecording2 = getaudiodata(recObj);
% 
% % Plot the waveform.
% plot(myRecording2);