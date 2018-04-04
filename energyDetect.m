function energyAngles = energyDetect(M, y, fs, c, d, time)
energyAngles = zeros(1,37);
for i = 0:36
    energySum = 0;
    signalAtAngle = DAS(M, fs, y, c, d, 5*i);
    maxMag = 0;
    for j = 1:length(y)
        if(signalAtAngle(j) > maxMag)
            maxMag = signalAtAngle(j);
        end
    end
    signalAtAngle = signalAtAngle*maxMag;
    for k = 1:length(y)
       energySum = energySum + abs(signalAtAngle(k))^2;
    end
    energyAngles(i+1) = energySum/time;
end
end