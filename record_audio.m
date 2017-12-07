function audio = record_audio(filename)
    if nargin < 1
        filename = [];
    end
    
    r = record_audio_dialog;
    audio = r.getaudiodata;
    
    if ~isempty(filename)
        audiowrite(filename,audio,44100);
    end
end
function [r, d] = record_audio_dialog()
    Fs = 44100;
    NBITS = 16;
    NCHANS = 1;
    ID = 1;
    r = audiorecorder(Fs,NBITS,NCHANS,ID);
    d = dialog('Position',[500,500,200,100],'Name','Record Audio');
    txt = uicontrol('Parent',d,...
        'Style','text',...
        'Position',[0,50,210,40],...
        'String', 'Press record when ready');
    rec_btn = uicontrol('Parent',d,...
        'Style','pushbutton',...
        'Position',[20,20,70,25],...
        'String', 'Record',...
        'Callback', {@record_callback, r});
    stop_btn = uicontrol('Parent',d,...
        'Style','pushbutton',...
        'Position',[110,20,70,25],...
        'String', 'stop',...
        'Callback', {@stop_callback, r});
    uiwait(d);
end
function record_callback(hObject,callbackdata,r)
    r.record;
end
function stop_callback(hObject,callbackdata,r)
    r.stop;
end