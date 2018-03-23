function [windSig, Sig] = DAS_Simulation2(M, wind, fs, inSig1, inSig2, c, R, d, inputTheta1, inputTheta2, steerTheta)
t = 0:1/fs:5;
inputTheta1 = inputTheta1*pi/180;
inputTheta2 = inputTheta2*pi/180;
steerTheta = steerTheta*pi/180;

mSig = zeros(M,length(t));
for i=1:M
    tauIn1 = round(sqrt((R*cos(inputTheta1))^2 + (R*sin(inputTheta1) + d*(i-1))^2)/c*fs);
    for j=1:length(mSig)
        if ((j > tauIn1) && (j <= tauIn1 + length(inSig1)))
            mSig(i,j) = mSig(i,j) + inSig1(j - tauIn1);
        end
    end
    mSig(i,1:length(t)) = awgn(mSig(i,1:length(t)),60);
end

for i=1:M
    tauIn2 = round(sqrt((R*cos(inputTheta2))^2 + (R*sin(inputTheta2) + d*(i-1))^2)/c*fs);
    for j=1:length(mSig)
        if ((j > tauIn2) && (j <= tauIn2 + length(inSig1)))
            mSig(i,j) = mSig(i,j) + inSig2(j - tauIn2);
        end
    end
    mSig(i,1:length(t)) = awgn(mSig(i,1:length(t)),60);
end

tic
DASsig = zeros(1,length(mSig));
Sig = zeros(1,length(mSig));

for i = 1:M
    tauSteer = round(sqrt((R*cos(steerTheta))^2 + (R*sin(steerTheta) + d*(i-1))^2)/c*fs);
    DASsig = DASsig + circshift(mSig(i,1:length(mSig)),-tauSteer);
    Sig = Sig + mSig(i,1:length(mSig));
end
windSig = zeros(1,length(DASsig));
DASsig = DASsig/M;
for i = 1:length(DASsig)
   windAvg = 0;
   for j = 1:wind
       if ((i+j) <= length(DASsig))
           windAvg = windAvg + DASsig(i+j-1);
       end
   end
   windAvg = windAvg/(wind/50);
   windSig(i) = windAvg;
end
toc

end