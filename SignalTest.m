close all
clear all

M = 20;
fs = 20000;
d = 0.05;
c = 343;
R = 1;
y = 0;

load('myRecording1.mat')
load('myRecording2.mat')
load('myRecording3.mat')

y = y + micArrayRec(M,fs,myRecording1,c,d,30);
y = y + micArrayRec(M,fs,myRecording2,c,d,90);
y = y + micArrayRec(M,fs,myRecording3,c,d,150);

z = DAS(M,fs,y,c,d,60);
sound(z,fs)