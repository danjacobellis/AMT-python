filenames = {
    ['midi_files' filesep 'tetrisA_mono_flute.mid']
    };
if ~exist('generated_audio_files','dir')
    mkdir('generated_audio_files')
end

Fs = 44100;
NBITS = 16;
NCHANS = 1;
ID = 1;
r = audiorecorder(Fs,NBITS,NCHANS,ID);

for i_file = 1:length(filenames)
    r.record;
    cmd_str = ['playsmf.exe --out 1 ' filenames{i_file}];
    [status,cmdout] = system(cmd_str);
    pause(3);
    r.stop;
    audio = r.getaudiodata;
    [pathstr, name, ext] = fileparts(filenames{i_file});
    new_filename = ['generated_audio_files' filesep name '.wav'];
    audiowrite(new_filename,audio,44100);
end