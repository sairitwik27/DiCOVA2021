function extract_fmnt(listfile)
addpath('/home/oem/Desktop')
addpath('/home/oem/Downloads/voicebox');
fp = fopen(listfile,'r'); 
C = textscan(fp,'%s %s %s');
fclose (fp); 

nfiles = size(C{1},1);
%FP_list={};
for i= 1:nfiles
    infile = C{2}(i,:);
    outfile = C{3}(i,:);
    
    disp(infile{1});
    disp(infile);

    [s, fs] = audioread(infile{1});

    [f0,~,pv,~]=fxpefac(s,fs,0.01);
    [ar,~] = lpcauto(s,18,round([0.01*fs, 0.020*fs])); % was 18 poles and 0.06*fs 
    [~,fxx] = lpcar2fm(ar); 
%fyy=fxx*fs; %converting into frequency in Hz
    minsize = min([ size(f0,1), size(fxx,1)]); 

    D = [f0(1:minsize)*2/fs, fxx(1:minsize,:), pv(1:minsize)];
    %figure; spectrogram(s,hamming(0.005*fs), 0.0010*fs,4096,fs,'yaxis'); % 5ms window, 1ms overlap 4ms shift
    %avg_pitch=mean(f0);
    %avg_frmnt=mean(fxx(:,1:5));
    %fp=[infile{1} {avg_pitch} {avg_frmnt}];
    %FP_list=[FP_list;fp]
  %  save('train_average_formants_pitch','FP_list')
    writehtk(outfile{1},D,0.01,9);
end
end

