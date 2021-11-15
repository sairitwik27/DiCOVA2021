function extract_fmnt_stats(listfile)

addpath('/home/oem/Downloads/voicebox');
fp = fopen(listfile,'r'); 
C = textscan(fp,'%s %s %s');
fclose (fp); 
nfiles = size(C{1},1);
fs=16000;
for i= 1:nfiles
    infile = C{2}(i,:);
    outfile = C{3}(i,:);
    
    %disp(infile{1});
    
    fxx = readhtk(infile{1});
    %disp(fbar)
    pv = fxx(:,end); 
    f0 = fxx(:,1);
    fxx = fxx(:,2:end-1);
     
    f0_r  =  f0 (pv>0.5,:); 
    %I1 =  (fxx(:,1) > 0); %(fxx(:,1) > 220/fs) & (fxx(:,1) < 800/fs);
    %I2 =  (fxx(:,2) > 0); %(fxx(:,2) > 400/fs) & (fxx(:,2) < 2000/fs); 
    %I3 =  (fxx(:,3) > 0); %(fxx(:,3) > 1500/fs) & (fxx(:,3) < 4000/fs);
    %I4 =  (fxx(:,4) > 0); %(fxx(:,4) > 0);

    I1 =  (fxx(:,1) > 220/fs ) & (fxx(:,1) < 800/fs ) ;
    I2 =  (fxx(:,2) > 400/fs ) &  (fxx(:,2) < 2000/fs ) ; 
    I3 =  (fxx(:,3) > 1500/fs ) & (fxx(:,3) < 4000/fs );
    I4 =  (fxx(:,4) > 1500);

    %fxx_r = fxx(I,:);
    %f00 = median(f0_r); 
    %fx0 = median(fxx_r); 

    % percentiles 
    pVals = [5,25, 50,75,95]; 
    pf0 = prctile(f0_r ,pVals);
    pf1 = prctile(fxx((pv>0.5),1), pVals); %5 x Nformants
    pf2 = prctile(fxx((pv>0.5),2), pVals); %5 x Nformants
    pf3 = prctile(fxx((pv>0.5),3), pVals); %5 x Nformants
    pf4 = prctile(fxx((pv>0.5),4), pVals); %5 x Nformants
%     
%     pf1 = prctile(fxx(I1,1), pVals); %5 x Nformants
%     pf2 = prctile(fxx(I2,2), pVals); %5 x Nformants
%     pf3 = prctile(fxx(I3,3), pVals); %5 x Nformants
%     pf4 = prctile(fxx(I4,4), pVals); %5 x Nformants

    %pVals = [25, 50,75 ]; 
    %dpf0 = prctile(df0_r ,pVals);
    %dpf1 = prctile(dfxx(I1,1), pVals); %5 x Nformants
    %dpf2 = prctile(dfxx(I2,2), pVals); %5 x Nformants
    %dpf3 = prctile(dfxx(I3,3), pVals); %5 x Nformants
    %%dpf4 = prctile(dfxx(I4,4), pVals); %5 x Nformants

    %pf5 = prctile(fxx(I5,5), pVals); %5 x Nformants
  
    %pcntl =  [ pf0 , pf1, pf2, pf3, pf4, dpf0, dpf1, dpf2, dpf3, dpf4, std(f0_r), std(df0_r), std(fxx(I1,1)), std(dfxx(I1,1)), std(fxx(I2,2)), std(dfxx(I2,2)), std(fxx(I3,3)),std(dfxx(I3,3)),std(fxx(I4,4)), std(dfxx(I4,4))];
    %pcntl =  [ pf0 , pf1, pf2, pf3, pf4, std(f0_r),  std(fxx(I1,1)), std(fxx(I2,2)), std(fxx(I3,3)),std(fxx(I4,4))];
    pcntl =  [pf1, pf2, pf3, pf4, std(fxx(I1,1)), std(fxx(I2,2)), std(fxx(I3,3)),std(fxx(I4,4))];
    Fx = sign(pcntl).*log(abs(pcntl)); 
    Fx(isnan(Fx)) = 0;
   fp = fopen(outfile{1},'wb');
   fwrite(fp,Fx,'double');  
   fclose(fp);
end

