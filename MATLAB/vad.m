function [x1,x2] = vad(x,a,b)

x = double(x);
x = x / max(abs(x));
 

FrameLen = 32e-3*fs; 
FrameInc = 16e-3*fs; 
 
amp1 = 10;
amp2 = 2;
zcr1 = 10;
zcr2 = 5;
 
maxsilence = 8;  

minlen  = 15;    
status  = 0;     
count   = 0;    
silence = 0;     
 

tmp1  = enframe(x(1:end-1), FrameLen, FrameInc);
tmp2  = enframe(x(2:end)  , FrameLen, FrameInc);
signs = (tmp1.*tmp2)<0;
diffs = (tmp1 -tmp2)>0.02;
zcr   = sum(signs.*diffs, 2);
 

amp = sum((abs(enframe( x, FrameLen, inc))).^2, 2);
 

TE=a*amp;
 

x1 = 0;
x2 = 0;
for n=1:length(zcr) 
   goto = 0;
   switch status
   case {0,1}                   
      if amp(n) < amp1          
         x1 = max(n-count-1,1);
         status  = 2;
         silence = 0;
         count   = count + 1;
      elseif amp(n) > amp2 | ... 
             zcr(n) > zcr2
         status = 1;
         count  = count + 1;
      else                       
         status  = 0;
         count   = 0;
      end
   case 2,                       
      if amp(n) > amp2 | ...     
         zcr(n) > zcr2
         count = count + 1;
      else                       
         silence = silence+1;
         if silence < maxsilence
            count  = count + 1;
         elseif count < minlen   
            status  = 0;
            silence = 0;
            count   = 0;
         else                    
            status  = 3;
         end
      end
   case 3,
      break;
   end
end  
count = count-silence/2;
x2 = x1 + count -1;
subplot(311)    
plot(x)
axis([1 length(x) -1 1])    
ylabel('Speech');
line([x1*FrameInc x1*FrameInc], [-1 1], 'Color', 'red');

line([x2*FrameInc x2*FrameInc], [-1 1], 'Color', 'red');
subplot(312)   
plot(amp);
axis([1 length(amp) 0 max(amp)])
ylabel('Energy');
line([x1 x1], [min(amp),max(amp)], 'Color', 'red');
line([x2 x2], [min(amp),max(amp)], 'Color', 'red');
subplot(313)
plot(zcr);
axis([1 length(zcr) 0 max(zcr)])
ylabel('ZCR');
line([x1 x1], [min(zcr),max(zcr)], 'Color', 'red');
line([x2 x2], [min(zcr),max(zcr)], 'Color', 'red');