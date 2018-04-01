function DASsig = DAS(M, fs, inSig, c, d, steer)
steer = steer*pi/180;

DASsig = zeros(1,length(inSig));
for i = 1:M
    if (steer <= pi/2)
        tauSteer = round(d*i*sin(steer)/c*fs);
    elseif ((steer > pi/2) && (steer <= pi))
        tauSteer = -round(d*i*sin(steer)/c*fs);
    else
        tauSteer = 0;
    end
    DASsig = DASsig + circshift(inSig(i,1:length(inSig)),-tauSteer);
end
DASsig = DASsig/M;

end