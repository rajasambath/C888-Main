function zcr=ZI(frame)

zcr=0;
for j=2: length(frame);        
      if abs(sign(frame(j))-sign(frame(j-1)))== 2      
           zcr=zcr+1;   
      elseif abs(sign(frame(j))-sign(frame(j-1)))== 1
          zcr=zcr+0.5;
      end
end
