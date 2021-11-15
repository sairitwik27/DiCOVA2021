function extract_harm(listfile)
tic;
addpath('/home/oem/Downloads/voicebox');
fp = fopen(listfile,'r'); 
C = textscan(fp,'%s %s %s');
fclose (fp); 

nfiles = size(C{1},1);
NPEAKS = 30;
pitch_list=zeros(nfiles,1);
for i= 1:nfiles
    infile = C{2}(i,:);
    outfile = C{3}(i,:);
    
    disp(infile{1});
    [s, fs] = audioread(infile{1});

    [f0,~,pv,~]=fxpefac(s,fs,0.01);
    [ar,~] = lpcauto(s,80,round([0.01*fs, 0.06*fs])); %was 82 poles
    [n,fxx] = lpcar2fm(ar); 
    %pitch_list(i)=median(f0);
    %pitch_list=pitch_list';
%% harmonics cross checking with spectrograms
%figure; plot(pv >0.5 )
%figure; spectrogram(s,hamming(0.060*fs), 0.050*fs,4096,fs,'yaxis');
%fxx(11:25, 6:10)*fs
 
%%
    disp(['min val ', num2str(min(n)) ]);
    minsize = min([ size(pv,1), size(fxx,1)]);   
    fxx = [fxx(1:minsize,1:NPEAKS),pv(1:minsize)];
    writehtk(outfile{1},fxx,0.01,9);
end

%save('male_pitch_median_ts_data_135p_25pk','pitch_list');
toc

