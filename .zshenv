export TERM=xterm-256color
export EDITOR=vim
export BROWSER=/opt/bin/firefox
export XDG_CONFIG_HOME=${HOME}/.config
export FCITX_CONFIG_DIR=${XDG_CONFIG_HOME}/fcitx

typeset -xT SUDO_PATH sudo_path
typeset -xT INFOPATH infopath
typeset -U path sudo_path cdpath fpath infopath manpath
sudo_path=(
    /usr/local/texlive/2019/bin/x86_64-linux(N-/)
    $sudo_path)
path=(
    $HOME/.local/bin(N-/)
    /usr/local/texlive/2019/bin/x86_64-linux(N-/)
    $path)
cdpath=(.. ~)
infopath=(/usr/local/texlive/2019/texmf-dist/doc/info(N-/) $infopath)
manpath=(/usr/local/texlive/2019/texmf-dist/doc/man(N-/) $manpath)

typeset -xT LD_LIBRARY_PATH ld_library_path
typeset -xT INCLUDE include
typeset -xT CPATH cpath
typeset -U  include cpath ld_library_path

include=($HOME/.local/include(N-/) $include)
cpath=($HOME/.local/include(N-/) $cpath)
ld_library_path=($HOME/.local/lib(N-/) $ld_library_path)

