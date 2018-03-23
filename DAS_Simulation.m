function DASsig = DAS_Simulation(fs, inSig1, c, R, d, inputTheta,steerTheta)
t = 0:1/fs:5;
delay = round(R/c);

tauIn = round(R/c*fs*cos(pi*(inputTheta + atan(d))/180));
mSig = zeros(16,length(t));
for i=1:16
    for j=1:length(mSig)
        if ((j > (delay+tauIn*i)) && (j <= (delay+tauIn*i) + length(inSig1)))
            mSig(i,j) = mSig(i,j) + inSig1(j - (delay+tauIn*i));
        end
    end
    mSig(i,1:length(t)) = awgn(mSig(i,1:length(t)),60);
end

figure
for i = 1:16
    subplot(16,1,i)
    plot(t,mSig(i,1:length(t)))
end

tauSteer = round(R/c*fs*cos(pi*(steerTheta + atan(d))/180));
DASsig = zeros(1,length(mSig));
figure
for i = 1:16
    subplot(16,1,i)
    DASsig = DASsig + circshift(mSig(i,1:length(mSig)),-tauSteer*i);
    plot(t,DASsig)
end
DASsig = DASsig/16;
figure
plot(t,DASsig)
axis([0 1 -1 1])
end