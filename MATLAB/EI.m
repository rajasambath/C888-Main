function E=EI(frame)

Y=fft(frame);  
nfft=length(Y); 
E=sum(abs(Y.^2))/nfft;  

