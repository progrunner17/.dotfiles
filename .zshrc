# vim:set filetype=zsh:
# 色を使用出来るようにする
# -U :alias展開しない
# -z :zsh形式で読み込み
autoload -Uz colors; colors

# プロンプト
# PROMPT="%{${fg[green]}%}[%n]%{${reset_color}%} %~
PROMPT="${fg[green]}[%n]${reset_color} %~
%# "
# setopt promptsubst
# PROMPT="%{$fg[black]%(?.$bg[green].$bg[red])%}<%?> \$history[\$((\$HISTCMD-1))]%{$reset_color%}
# (%n@%m)[%h] %~ %% "

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# 単語の区切り文字を指定する
autoload -Uz select-word-style; select-word-style default

# ここで指定した文字は単語区切りとみなされる
# / も区切りと扱うので、^W でディレクトリ１つ分を削除できる
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

##################補完######################
# 補完
# 補完機能を有効にする
autoload -Uz compinit; compinit


# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'


###################version control system(git)#####################
# vcs_info
# git

# autoload -Uz vcs_info
# autoload -Uz add-zsh-hook

# zstyle ':vcs_info:*' formats '%F{green}(%s)-[%b]%f'
# zstyle ':vcs_info:*' actionformats '%F{red}(%s)-[%b|%a]%f'

# function _update_vcs_info_msg() {
#     LANG=en_US.UTF-8 vcs_info
#     RPROMPT="${vcs_info_msg_0_}"

# }
# add-zsh-hook precmd _update_vcs_info_msg


##################落ち穂拾い######################
# オプション
# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# beep を無効にする
setopt no_beep

# フローコントロールを無効にする
setopt no_flow_control

# Ctrl+Dでzshを終了しない
setopt ignore_eof

# '#' 以降をコメントとして扱う
setopt interactive_comments

# ディレクトリ名だけでcdする
setopt auto_cd

# cd したら自動的にpushdする
setopt auto_pushd

# 重複したディレクトリを追加しない
setopt pushd_ignore_dups

setopt autonamedirs
setopt cdable_vars
hash -d pdf=$HOME/Documents/pdf


# 同時に起動したzshの間でヒストリを共有する
setopt share_history

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# スペースから始まるコマンド行はヒストリに残さない
# setopt hist_ignore_space

# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

# 高機能なワイルドカード展開を使用する
setopt extended_glob

########################################
# キーバインド

# ^R で履歴検索をするときに * でワイルドカードを使用出来るようにする
bindkey '^R' history-incremental-pattern-search-backward
bindkey -e

#################alias#######################
alias la='ls -a'
alias ll='ls -lh'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias less='less -XF'
alias mkdir='mkdir -p'

# sudo の後のコマンドでエイリアスを有効にする
alias sudo='sudo '

# グローバルエイリアス
alias -g L='| less'
alias -g G='| grep'
alias -g P='| peco'


case ${OSTYPE} in
    darwin*)
        #Mac用の設定
        export CLICOLOR=1
        alias ls='ls -G -F'
        ;;
    linux*)
        #Linux用の設定
        alias ls='ls -F --color=auto'
        ;;
esac



###############クリップボード################
# C で標準出力をクリップボードにコピーする
# mollifier delta blog : http://mollifier.hatenablog.com/entry/20100317/p1
if which pbcopy >/dev/null 2>&1 ; then
    # Mac
    alias -g C='| pbcopy'
elif which xsel >/dev/null 2>&1 ; then
    # Linux
    alias -g C='| xsel --input --clipboard'
elif which putclip >/dev/null 2>&1 ; then
    # Cygwin
    alias -g C='| putclip'
fi


test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
export LESSOPEN='| /usr/local/bin/src-hilite-lesspipe.sh %s'
export LESS='-gj10 --no-init --quit-if-one-screen --RAW-CONTROL-CHARS'

[[ -d ~/.rbenv  ]] && \
  export PATH=${HOME}/.rbenv/bin:${PATH} && \
    eval "$(rbenv init -)"

# [[ -s /Users/shotaro/.tmuxinator/scripts/tmuxinator ]] && source /Users/shotaro/.tmuxinator/scripts/tmuxinator
export EDITOR='/usr/bin/vim'

alias top=htop

alias ws=/Users/shotaro/workspace/esolang/whitespace/whitespacers/c/ws



############GCP###################################
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/shotaro/workspace/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/shotaro/workspace/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/shotaro/workspace/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/shotaro/workspace/google-cloud-sdk/completion.zsh.inc'; fi



###########各種言語設定##############
# python
eval "$(pyenv init -)"

# ruby
eval "$(rbenv init -)"

# OPAM configuration
. /Users/shotaro/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
alias ocaml='rlwrap ocaml'



###########zplug の設定###############
source $ZPLUG_HOME/init.zsh
# Make sure to use double quotes
zplug "zsh-users/zsh-history-substring-search"
zplug "kagamilove0707/moonline.zsh", from:github
source $ZPLUG_HOME/repos/kagamilove0707/moonline.zsh/moonline.zsh
moonline initialize
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-autosuggestions", defer:2
zplug "zsh-users/zsh-completions", defer:2

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi



# Then, source plugins and add commands to $PATH
zplug load --verbose

# Use the package as a command
# And accept glob patterns


