function r= correlation(H,w)

Ns=length(H(1,:));
D=length(H(:,1)); 
Nr=floor(Ns/w-1);  
r=zeros(1,Nr); 


for i=1:Nr
    w_start=(i-1)*w+1;
    w_end=w_start+2*w-1;
    H1=H(:,(w_start:w_start+w-1)); 
    H2=H(:,(w_start+w:w_end)); 
    Hi1=zeros(D,1);Hi2=zeros(D,1); 
    for j=1:D
        Hi1(j)=mean(H1(j,:));
        Hi2(j)=mean(H2(j,:));
    end
    ave1=mean(Hi1);    ave2=mean(Hi2); 
    rup=sum((Hi1-ave1).*(Hi2-ave2));
    r(i)=rup/(std(Hi1)*std(Hi2)*(D-1)); 
end

       
       
        
    
    
