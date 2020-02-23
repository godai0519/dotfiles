# Created by newuser for 5.0.0

### Alias ###
alias l='ls -a'
alias ll='ls -la'
alias ls='ls --color=auto'
alias ks='ls --color=auto'
alias grep='grep --color=auto'
alias diff='colordiff'
alias mkdir='mkdir -p -v'
alias sudo="sudo env PATH=\"SUDO_PATH:$PATH\""

if [[ -n “$TMUX” ]]; then
    bindkey '\e[1~' beginning-of-line
    bindkey '\e[4~' end-of-line
fi

### Git Alias ### 
# {{{1
alias gs='git status'
alias gss='git status -s'
alias ga='git add'
alias gap='git add -p'

alias gst='git log --oneline --decorate --color --graph'
alias gl='git log --oneline'
alias gln='git log --name-only'
for n in $(seq 50); do
    alias gl$n="git log --oneline -n $n | tee"
done

alias gd='git diff'
alias gdn='git diff --name-only'
for n in $(seq 50); do
    alias gd$n="git diff HEAD~$n"
    alias gdn$n="git diff --name-only HEAD~$n"
done

alias gci='git commit'
alias gcm='git commit -m'
alias gca='git commit --amend'

alias gco='git checkout'
alias gcot='git checkout --theirs'

alias grhh='git reset HEAD --hard'
# }}}

### Sudo Alias ###
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
setopt TRANSIENT_RPROMPT # 右プロンプトに入力がきたら消す

zstyle :compinstall filename '~/.zshrc'
autoload -Uz compinit
compinit

zstyle ':completion:*:default' menu select=1
zstyle ':completion:*:sudo:*' environ PATH="$SUDO_PATH:$PATH"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

### Prompt###
# プロンプトに色を付ける
autoload -Uz colors;colors

# 一般ユーザ時
tmp_prompt="%{$fg[red]%}%n%{$reset_color%} %{${fg[green]}%}%~%{${reset_color}%} %{$reset_color%}%# "
tmp_prompt2="%{${fg[cyan]}%}%_> %{${reset_color}%}"
tmp_rprompt="[%{$fg_no_bold[yellow]%}%?%{$reset_color%}]"
#tmp_sprompt="%{${fg[yellow]}%}%r is correct? [Yes, No, Abort, Edit]:%{${reset_color}%}"
tmp_sprompt="%{$fg_bold[red]%}correct%{$reset_color%}: %R -> %r ? "

PROMPT=$tmp_prompt    # 通常のプロンプト
PROMPT2=$tmp_prompt2  # セカンダリのプロンプト(コマンドが2行以上の時に表示される)
RPROMPT=$tmp_rprompt  # 右側のプロンプト
SPROMPT=$tmp_sprompt  # スペル訂正用プロンプト
REPORTTIME=3 # 3秒以上で実行時間

# vcs用表示
# http://qiita.com/mollifier/items/8d5a627d773758dd8078 {{{1
autoload -Uz vcs_info
autoload -Uz add-zsh-hook

zstyle ':vcs_info:*' max-exports 3

# 標準のフォーマット(git 以外で使用)
# misc(%m) は通常は空文字列に置き換えられる
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b]' '%m' '<!%a>'
zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
zstyle ':vcs_info:bzr:*' use-simple true

# git 用のフォーマット
# git のときはステージしているかどうかを表示
zstyle ':vcs_info:git:*' formats '%c%u(%s)-[%b' '%m]%f'
zstyle ':vcs_info:git:*' actionformats '%c%u(%s)-[%b' '%m]%f' '<!%a>'
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%f"    # %c で表示する文字列
zstyle ':vcs_info:git:*' unstagedstr "%f"  # %u で表示する文字列

# hooks 設定
zstyle ':vcs_info:git+set-message:*' hooks \
                                        git-hook-begin \
                                        git-untracked \
                                        git-nothing-added \
                                        git-push-status \
                                        git-nomerge-branch \
                                        git-stash-count

function +vi-git-hook-begin() {
    if [[ $(command git rev-parse --is-inside-work-tree 2> /dev/null) != 'true' ]]; then
        # 0以外を返すとそれ以降のフック関数は呼び出されない
        return 1
    fi

    return 0
}

# nothing-added
function +vi-git-nothing-added() {
    if [[ "$1" != "0" ]]; then
        return 0
    fi

    if command git status --porcelain 2> /dev/null \
        | awk '{print $1}' \
        | command grep -F 'M' > /dev/null 2>&1 ; then
        hook_com[unstaged]+='%F{red}'
    fi
}

# untracked
function +vi-git-untracked() {
    if [[ "$1" != "0" ]]; then
        return 0
    fi

    if command git status --porcelain 2> /dev/null \
        | awk '{print $1}' \
        | command grep -F '??' > /dev/null 2>&1 ; then

        # unstaged (%u) に追加
        hook_com[unstaged]+='%F{cyan}'
    fi
}

# push していないコミットの件数表示
#
# リモートリポジトリに push していないコミットの件数を
# pN という形式で misc (%m) に表示する
function +vi-git-push-status() {
    if [[ "$1" != "0" ]]; then
        return 0
    fi

    if [[ "${hook_com[branch]}" != "master" ]]; then
        # master ブランチでない場合は何もしない
        return 0
    fi

    # push していないコミット数を取得する
    local ahead
    ahead=$(command git rev-list origin/master..master 2>/dev/null \
        | wc -l \
        | tr -d ' ')

    if [[ "$ahead" -gt 0 ]]; then
        # misc (%m) に追加
        hook_com[misc]+="(p${ahead})"
    fi
}

# マージしていない件数表示
#
# master 以外のブランチにいる場合に、
# 現在のブランチ上でまだ master にマージしていないコミットの件数を
# (mN) という形式で misc (%m) に表示
function +vi-git-nomerge-branch() {
    if [[ "$1" != "0" ]]; then
        return 0
    fi

    if [[ "${hook_com[branch]}" == "master" ]]; then
        # master ブランチの場合は何もしない
        return 0
    fi

    local nomerged
    nomerged=$(command git rev-list master..${hook_com[branch]} 2>/dev/null | wc -l | tr -d ' ')

    if [[ "$nomerged" -gt 0 ]] ; then
        # misc (%m) に追加
        hook_com[misc]+="(m${nomerged})"
    fi
}


# stash 件数表示
#
# stash している場合は :SN という形式で misc (%m) に表示
function +vi-git-stash-count() {
    if [[ "$1" != "0" ]]; then
        return 0
    fi

    local stash
    stash=$(command git stash list 2>/dev/null | wc -l | tr -d ' ')
    if [[ "${stash}" -gt 0 ]]; then
        # misc (%m) に追加
        hook_com[misc]+=":S${stash}"
    fi
}

function _update_vcs_info_msg() {
    local -a messages
    local prompt

    LANG=en_US.UTF-8 vcs_info

    if [[ -z ${vcs_info_msg_0_} ]]; then
        # vcs_info で何も取得していない場合はプロンプトを表示しない
        prompt=""
    else
        # vcs_info で情報を取得した場合
        # $vcs_info_msg_0_ , $vcs_info_msg_1_ , $vcs_info_msg_2_ を
        # それぞれ緑、黄色、赤で表示する
        [[ -n "$vcs_info_msg_0_" ]] && messages+=( "%F{green}${vcs_info_msg_0_}${vcs_info_msg_1_}%f" )
        [[ -n "$vcs_info_msg_2_" ]] && messages+=( "%F{red}${vcs_info_msg_2_}%f" )

        # 間にスペースを入れて連結する
        prompt="${(j: :)messages}"
    fi

    RPROMPT="$prompt $tmp_rprompt"
}
add-zsh-hook precmd _update_vcs_info_msg
#}}}

# zsh キー設定 #
bindkey "^[[7~" beginning-of-line                 # Home
bindkey "^[[8~" end-of-line                       # End
bindkey "^[[3~" delete-char                       # Delete
bindkey "^[[2~" overwrite-mode                    # Insert
bindkey "^[[5~" history-beginning-search-backward # Page Up
bindkey "^[[6~" history-beginning-search-forward  # Page Down

# vim:set foldmethod=marker:

