function mSig = micArrayRec2(M, fs, prevSig, inSig, c, d, inputTheta)
if (length(prevSig) < length(inSig))
    mSig = zeros(M,length(inSig));
else
    mSig = zeros(M,length(prevSig));
end
length(prevSig)
length(inSig)
inputTheta = inputTheta*pi/180;

for i=1:M
    if (inputTheta <= pi/2)
        tauIn = round(d*i*sin(inputTheta)/c*fs);
    elseif ((inputTheta > pi/2) && (inputTheta <= pi))
        tauIn = -round(d*i*sin(inputTheta)/c*fs);
    else
        tauIn = 0;
    end
    
    oldSig = prevSig(i,:);
    if (length(oldSig) > length(inSig))
        delayed = padarray(inSig,length(oldSig),'post');
        'case 1'
    elseif (length(oldSig) < length(inSig))
        oldSig = padarray(oldSig,length(inSig),'post');
        delayed = inSig;
        'case 2'
    else
        delayed = zeros(1,length(oldSig));
        'else'
    end
    delayed = circshift(delayed,tauIn);

    for j=1:length(mSig)
        mSig(i,j) = mSig(i,j) + delayed(j) + oldSig(j);
    end
end

end