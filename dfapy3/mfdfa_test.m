% import ts from python
ts = csvread("ts.csv");

%f = figure(1);
%subplot(2,1,1), plot(ts);


X = cumsum(ts - mean(ts));
%subplot(2,1,2), plot(X)

% parameters
%X = transpose(X);
scale = [16,32,64,128,256,512,1024];
q = [-5,-3,-1,0,1,3,5];
m = 1;

% part 1
for ns=1:length(scale),
    segments(ns) = floor(length(X)/scale(ns));
        
    for v = 1:segments(ns),
        Index = ((((v-1) * scale(ns))+1):(v*scale(ns)));
        C=polyfit(Index,X(Index),m);        
        fit=polyval(C,Index);
        RMS{ns}(v)=sqrt(mean((X(Index)-fit).^2)); 
    end
    for nq=1:length(q),
        qRMS{nq,ns}=RMS{ns}.^q(nq);
        Fq(nq,ns)=mean(qRMS{nq,ns}).^(1/q(nq));
        if q(nq) == 0
            disp(ns)
            %disp(sum(RMS{ns}))% identical input
            disp(sum(log(RMS{ns}.^2)))
        end
    end
    Fq(q==0,ns)=exp(0.5*mean(log(RMS{ns}.^2)));
    %disp(Fq(q==0,ns))
    %disp(exp(1))
    
end

% part 2
for nq=1:length(q),
    C=polyfit(log2(scale),log2(Fq(nq,:)),1);
    Hq(nq)=C(1);
    qRegLine{nq}=polyval(C,log2(scale));
end
Hq