function [windSig, Sig] = DAS_Simulation3(M, wind, fs, inSig1, inSig2, c, R1, R2, RSteer, d, inputTheta1, inputTheta2, steerTheta)
t = 0:1/fs:5;
inputTheta1 = inputTheta1*pi/180;
inputTheta2 = inputTheta2*pi/180;
steerTheta = steerTheta*pi/180;

mSig = zeros(M,length(t));
for i=1:M
    if (inputTheta1 <= 90*pi/180)
        tauIn1 = round(sqrt((R1*cos(inputTheta1))^2 + (R1*sin(inputTheta1) + d*(i-1))^2)/c*fs);
    elseif ((inputTheta1 > 90*pi/180) && (inputTheta1 <= 180*pi/180))
        tauIn1 = -round(sqrt((R1*cos(inputTheta1))^2 + (R1*sin(inputTheta1) + d*(i-1))^2)/c*fs);
    else
        tauIn1 = 0;
    end
    for j=1:length(mSig)
        if ((j > tauIn1) && (j <= tauIn1 + length(inSig1)))
            mSig(i,j) = mSig(i,j) + inSig1(j - tauIn1);
        end
    end
    mSig(i,1:length(t)) = (awgn(mSig(i,1:length(t)),60));
end

for i=1:M
    if (inputTheta2 <= 90*pi/180)
        tauIn2 = round(sqrt((R2*cos(inputTheta2))^2 + (R2*sin(inputTheta2) + d*(i-1))^2)/c*fs);
    elseif ((inputTheta2 > 90*pi/180) && (inputTheta2 <= 180*pi/180))
        tauIn2 = round(sqrt((R2*cos(inputTheta2))^2 + (R2*sin(inputTheta2) + d*(i-1))^2)/c*fs);
    else
        tauIn2 = 0;
    end
    for j=1:length(mSig)
        if ((j > tauIn2) && (j <= tauIn2 + length(inSig1)))
            mSig(i,j) = mSig(i,j) + inSig2(j - tauIn2);
        end
    end
    mSig(i,1:length(t)) = (awgn(mSig(i,1:length(t)),60));
end

tic
DASsig = zeros(1,length(mSig));
Sig = zeros(1,length(mSig));

for i = 1:M
    if (steerTheta <= 90*pi/180)
        tauSteer = round(sqrt((RSteer*cos(steerTheta))^2 + (RSteer*sin(steerTheta) + d*(i-1))^2)/c*fs);
    elseif ((steerTheta > 90*pi/180) && (steerTheta <= 180*pi/180))
        tauSteer = -round(sqrt((RSteer*cos(steerTheta))^2 + (RSteer*sin(steerTheta) + d*(i-1))^2)/c*fs);
    else
        tauSteer = 0;
    end
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
   windAvg = windAvg/(wind);
   windSig(i) = windAvg;
end
toc

end