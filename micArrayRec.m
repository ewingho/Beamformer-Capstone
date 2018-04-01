function mSig = micArrayRec(M, fs, inSig, c, d, inputTheta)
inputTheta = inputTheta*pi/180;
mSig = zeros(M,2*length(inSig));
for i=1:M
    if (inputTheta <= pi/2)
        tauIn = round(d*i*sin(inputTheta)/c*fs);
    elseif ((inputTheta > pi/2) && (inputTheta <= pi))
        tauIn = -round(d*i*sin(inputTheta)/c*fs);
    else
        tauIn = 0;
    end
    delayed = padarray(inSig,2*length(inSig),'post');
    delayed = circshift(delayed,tauIn);

    for j=1:length(mSig)
        mSig(i,j) = mSig(i,j) + delayed(j);
    end
end

end