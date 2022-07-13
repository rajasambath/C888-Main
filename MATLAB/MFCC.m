function H=MFCC(S)

bank=melbankm(24,512,16000); 

bank=full(bank);
bank=bank/max(bank(:));
for k=1:12			
n=0:23;
dctcoef(k,:)=cos((2*n+1)*k*pi/(2*24));
end
w=1+6*sin(pi*[1:12]./12);


for i=1:length(S(:,1))
    s=S(i,:);
	t=abs(fft(s)); 
    t=t.^2';
	c1=dctcoef*log(bank*t(1:257)+eps);
c2=c1.*w';
m(i,:)=c2';
c2=m;
end


D0=length(c2(1,:));   
D1=(D0+1)*(D0+2)/2; 
H=zeros(D1,length(S(:,1))); 
for i=1:length(c2(:,1))
    c2i=[1,c2(i,:)]; 
    h_end=0;
    for j=1:D0+1
        h_start=h_end+1; 
        h_end=h_start+D0-j+1;
        k=j;
        for location=h_start:h_end
            H(location,i)=c2i(j)*c2i(k);
            k=k+1;
        end
    end
end
        
        
        

