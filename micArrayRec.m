function mSig = micArrayRec(M, fs, inSig, c, R, d, inputTheta)
inputTheta = inputTheta*pi/180;

mSig = zeros(M,length(inSig));
for i=1:M
    if (inputTheta <= pi/2)
        tauIn = round(sqrt((cos(inputTheta))^2 + (sin(inputTheta) + d*(i-1))^2)/c*fs);
    elseif ((inputTheta > pi/2) && (inputTheta <= pi))
        tauIn = -round(sqrt((cos(inputTheta))^2 + (sin(inputTheta) + d*(i-1))^2)/c*fs);
    else
        tauIn = 0;
    end
    delayed = circshift(inSig,tauIn)/(R^2);
    for j=1:length(mSig)
        mSig(i,j) = mSig(i,j) + delayed(j);
    end
    
end

end