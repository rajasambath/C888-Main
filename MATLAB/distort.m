function Q = distort(R,k1,k2)


Tp=k1*mean(R); 
R_diff=zeros(length(R)-1,1);
for i=1:(length(R)-1)
    R_diff(i)=R(i+1)-R(i);
end
Tp_diff=k2*mean(abs(R_diff));
Q=[];
for i=1:(length(R)-1)
    if R(i)<Tp&&abs(R_diff(i))>Tp_diff
        Q=[Q,i];
    end
end


    