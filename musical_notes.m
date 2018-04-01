fs = 20000;
t = 0:1/fs:1;
c4 = sin(2*pi*261.63*t);
d4 = sin(2*pi*293.66*t);
e4 = sin(2*pi*329.63*t);

sound(e4,fs)
pause(0.9)
sound(d4,fs)
pause(0.9)
sound(c4,fs)

pause(1.8)
sound(e4,fs)
pause(0.9)
sound(d4,fs)
pause(0.9)
sound(c4,fs)

pause(1.15)

t = 0:1/fs:0.4;
c4 = sin(2*pi*261.63*t);
d4 = sin(2*pi*293.66*t);
sound(c4,fs)
pause(0.45)
sound(c4,fs)
pause(0.45)
sound(c4,fs)
pause(0.45)
sound(c4,fs)
pause(0.45)
sound(d4,fs)
pause(0.45)
sound(d4,fs)
pause(0.45)
sound(d4,fs)
pause(0.45)
sound(d4,fs)

t = 0:1/fs:1;
c4 = sin(2*pi*261.63*t);
d4 = sin(2*pi*293.66*t);
e4 = sin(2*pi*329.63*t);

pause(0.50)
sound(e4,fs)
pause(0.9)
sound(d4,fs)
pause(0.9)
sound(c4,fs)