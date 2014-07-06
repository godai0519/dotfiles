# Created by newuser for 5.0.0

### Alias ###
alias l='ls -a'
alias ll='ls -la'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias g='git'
alias diff='colordiff'
alias mkdir='mkdir -p -v'

if [ $UID -ne 0 ]; then
    alias svim='sudoedit'
    alias netctl='sudo netctl'
    alias reboot='sudo systemctl reboot'
    alias powetoff='sudo systemctl poweroff'
fi

### History Settings ###
HISTFILE=~/.zsh_history   # ヒストリを保存するファイル
HISTSIZE=10000            # メモリに保存されるヒストリの件数
SAVEHIST=10000            # 保存されるヒストリの件数
setopt bang_hist          # !を使ったヒストリ展開を行う(d)
setopt extended_history   # ヒストリに実行時間も保存する
setopt hist_ignore_dups   # 直前と同じコマンドはヒストリに追加しない
setopt share_history      # 他のシェルのヒストリをリアルタイムで共有する
setopt hist_reduce_blanks # 余分なスペースを削除してヒストリに保存する

### Option ###
setopt no_beep
setopt auto_cd
setopt auto_pushd        # cd時にディレクトリスタックにpushdする
setopt correct           # コマンドのスペルを訂正する
setopt magic_equal_subst # =以降も補完する(--prefix=/usrなど)
setopt prompt_subst      # プロンプト定義内で変数置換やコマンド置換を扱う
setopt notify            # バックグラウンドジョブの状態変化を即時報告する

zstyle :compinstall filename '~/.zshrc'
autoload -Uz compinit
compinit

zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                     /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

### Prompt###
# プロンプトに色を付ける
autoload -Uz colors;colors

# 一般ユーザ時
tmp_prompt="%{$fg[red]%}%n%{$reset_color%}@%{$fg[cyan]%}%m %{${fg[green]}%}%~%{${reset_color}%} %{$reset_color%}%# "
tmp_prompt2="%{${fg[cyan]}%}%_> %{${reset_color}%}"
tmp_rprompt="[%{$fg_no_bold[yellow]%}%?%{$reset_color%}]"
#tmp_sprompt="%{${fg[yellow]}%}%r is correct? [Yes, No, Abort, Edit]:%{${reset_color}%}"
tmp_sprompt="%{$fg_bold[red]%}correct%{$reset_color%}: %R -> %r ? "

# rootユーザ時(太字にし、アンダーバーをつける)
if [ ${UID} -eq 0 ]; then
  tmp_prompt="%B%U${tmp_prompt}%u%b"
  tmp_prompt2="%B%U${tmp_prompt2}%u%b"
  tmp_rprompt="%B%U${tmp_rprompt}%u%b"
  tmp_sprompt="%B%U${tmp_sprompt}%u%b"
fi

PROMPT=$tmp_prompt    # 通常のプロンプト
PROMPT2=$tmp_prompt2  # セカンダリのプロンプト(コマンドが2行以上の時に表示される)
RPROMPT=$tmp_rprompt  # 右側のプロンプト
SPROMPT=$tmp_sprompt  # スペル訂正用プロンプト
REPORTTIME=3 # 3秒以上で実行時間

# zsh キー設定 #
bindkey "^[[7~" beginning-of-line                 # Home
bindkey "^[[8~" end-of-line                       # End
bindkey "^[[3~" delete-char                       # Delete
bindkey "^[[2~" overwrite-mode                    # Insert
bindkey "^[[5~" history-beginning-search-backward # Page Up
bindkey "^[[6~" history-beginning-search-forward  # Page Down

