export TERM=xterm-256color
export EDITOR=vim
export LANG=ja_JP.UTF-8

export BOOST_ROOT=$HOME/.updater/boost

typeset -U path
path=(
    # Boost
    $BOOST_ROOT(N-/)

    # Users
    $HOME/bin(N-/)
    $HOME/local/bin(N-/)

    # System
    /usr/local/bin(N-/)
    /usr/bin(N-/)
)

unset LD_LIBRARY_PATH
typeset -xT LD_LIBRARY_PATH ld_library_path
typeset -U ld_library_path
ld_library_path=(
    /usr/local/gcc/lib/gcc/x86_64-unknown-linux-gnu/5.0.0(N-/)
    /usr/local/lib(N-/)
)

unset FCITX_CONFIG_DIR
typeset -xT FCITX_CONFIG_DIR fcitx_config_dir
typeset -U fcitx_config_dir
fcitx_config_dir=(
    $HOME/.local/share/fcitx(N-/)
)

