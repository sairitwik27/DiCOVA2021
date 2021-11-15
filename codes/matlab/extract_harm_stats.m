function extract_harm_stats(listfile)

addpath('/home/oem/Downloads/voicebox');
fp = fopen(listfile,'r'); 
C = textscan(fp,'%s %s %s');
fclose (fp); 

nfiles = size(C{1},1);
%NPEAKS = 30

fc = 7/16 ; 

for i= 1:nfiles
    infile = C{2}(i,:);
    outfile = C{3}(i,:);
    disp(size(infile{1}));

    [ fxx ]  = readhtk(infile{1});
    pv = fxx(:,end);
    fxx = fxx(:,1:end-1);
    NPEAKS = size(fxx,2);
 
%     I =   (fxx(:,1) > 0 ) ; 
%     for i = 2:NPEAKS 
%        I =  I & (fxx(:,i) > 0 ) ; 
%     end
    I = (pv>0.5); 
    
    %th1 = round(size(I,1)/3); 
   % th2 = round(size(I,1)*2/3); 
    pVals = [5  25, 50,75 95]; 
    pf = prctile(fxx(I,:), pVals); 


    pcntl =  [reshape(pf,1,[]), std(pf)  ];
    Fx = sign(pcntl).*log(abs(pcntl) ); 
    Fx(isnan(Fx)) = 0;
      
   fp = fopen(outfile{1},'wb');
   fwrite(fp,Fx,'double');  
   fclose(fp);
end

