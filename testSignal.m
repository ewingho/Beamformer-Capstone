close all
clear all

load('myRecording1.mat')
load('myRecording2.mat')
load('myRecording3.mat')
fs = 20000;
c = 343;
d = 0.5;
inputTheta1 = 100;
inputTheta2 = 180;
steerTheta = 180;
M = 100;
% wind = 1;

% t = 1:length(myRecording1);
% figure
% subplot(4,1,1)
% plot(t,myRecording1)
% title(['Waveform for sound source at angle ' int2str(inputTheta1) ' degrees'])
% xlabel('Time in 10^-4 seconds')
% ylabel('Amplitude(V)')
% %sound(myRecording1,fs)
% 
% %pause(2)
% 
% subplot(4,1,2)
% plot(t,myRecording2)
% title(['Waveform for sound source at angle ' int2str(inputTheta2) ' degrees'])
% xlabel('Time in 10^-4 seconds')
% ylabel('Amplitude(V)')
% %sound(myRecording2,fs)
% 
% [y, z] = DAS_Simulation4(M, wind, fs, myRecording1, myRecording2, c, R1, R2, RSteer, d, inputTheta1, inputTheta2, steerTheta);
% t = 1:length(y);
% subplot(4,1,3)
% plot(t,z)
% title('Waveform for the sum of all microphone inputs')
% xlabel('Time in 10^-4 seconds')
% ylabel('Amplitude(V)')
% xlim([0 4*10^4])
% 
% subplot(4,1,4)
% plot(t,y)
% title(['Waveform for delay-and-sum of all microphone inputs steered to ' int2str(steerTheta) ' degrees']) 
% xlabel('Time in 10^-4 seconds')
% ylabel('Amplitude(V)')
% xlim([0 4*10^4])
% 
% sound(myRecording1+myRecording2,fs)
% pause(2)
% sound(y,fs)

y = 0;
y = y + micArrayRec(M, fs, myRecording1, c, d, 30);
y = y + micArrayRec(M, fs, myRecording2, c, d, 90);
y = y + micArrayRec(M, fs, myRecording3, c, d, 150);

% sound(y(1,1:length(y)),fs);
% pause(5);
z = DAS(M,fs,y,c,d,150);
sound(z,fs)