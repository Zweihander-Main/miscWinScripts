if(get-process | ?{$_.Name -Match "emacs-"}){
    bash -c "pkill -f emacs"
}
bash -c "emacs --daemon"
