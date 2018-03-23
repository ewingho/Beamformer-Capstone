function DASsig = DAS(M, fs, inSig, c, d, steer)
steer = steer*pi/180;

DASsig = zeros(1,length(inSig));
for i = 1:M
    if (steer <= pi/2)
        tauSteer = round(sqrt((cos(steer))^2 + (sin(steer) + d*(i-1))^2)/c*fs);
    elseif ((steer > pi/2) && (steer <= pi))
        tauSteer = -round(sqrt((cos(steer))^2 + (sin(steer) + d*(i-1))^2)/c*fs);
    else
        tauSteer = 0;
    end
    DASsig = DASsig + circshift(inSig(i,1:length(inSig)),-tauSteer);
end
DASsig = DASsig/M;

end