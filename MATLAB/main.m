
clear all
close all
[montage1,fs]=audioread('montage2.wav');

montage1=montage1(:,1);
figure(1)
plot(montage1);

title('Digital signal processing');
xlabel('Time'); ylabel('Amplitude');

framelen=32e-3*fs;
frameinc=16e-3*fs; 
window=hamming(framelen); 
x=enframe(montage1,window,frameinc);

[S,k]=unvad(x,0.8,1,fs);
H=MFCC(S);


terror=64e-3; 
w=floor(terror/16e-3); 
R=correlation(H,w);
figure(4)
plot(R);
title('Signals');

Q=distort(R,0.6,3.6);
if isempty(Q)
    disp('Audio forgery detection');
else 
    S_distort=[];
    disp('Audio forgery detection');
    for i=1:length(Q)
        S_distort= [S_distort Q(i)*w];
    end
    t_distort=k(S_distort)*256;tt=0.8*ones(1,length(t_distort));
    figure(5)
    plot(montage1);
    hold on 
    stem(t_distort,tt);
    title('Frequency');
end

