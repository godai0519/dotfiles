export TERM=xterm-256color
export EDITOR=vim
export XDG_CONFIG_HOME=${HOME}/.config

typeset -U path
path=(
    $HOME/local/bin(N-/)
    $path
    )

unset http_proxy
unset HTTP_PROXY
unset https_proxy
unset HTTPS_PROXY
unset ftp_proxy
unset FTP_PROXY
unset all_proxy
unset ALL_PROXY
unset no_proxy
unset NO_PROXY

