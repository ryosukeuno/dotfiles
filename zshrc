## Environment variables configuration
#
# LANG
#
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

# Macports
case ${OSTYPE} in
    darwin*)
        export JVM_OPTS='-Djava.awt.headless=true'
        export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/1.6/Home
        export PATH=/opt/local/bin:$JAVA_HOME/bin:$PATH
        export LIBRARY_PATH=/opt/local/lib:$LIBRARY_PATH
        export LD_LIBRARY_PATH=/opt/local/lib:$LD_LIBRARY_PATH
        export C_INCLUDE_PATH=/opt/local/include:$C_INCLUDE_PATH
        export CPLUS_INCLUDE_PATH=/opt/local/include:$CPLUS_INCLUDE_PATH
        export DYLD_FALLBACK_LIBRARY_PATH=/opt/local/lib
        export BOOST_ROOT=/opt/local/include/boost:$BOOST_ROOT
        ;;
esac

export PATH=$HOME/bin:$PATH

# EDITOR
#
export EDITOR='vi'
export PAGER='less'
export LESS='--tabs=4 --no-init --long-prompt --ignore-case'
export LESSEDIT='vi %f'

# make less more friendly
autoload colors
colors
export LESS_TERMCAP_md="${terminfo[bold]}${fg_bold[white]}" # bold/ bright
export LESS_TERMCAP_mh="${fg[white]}"                       # dim/ half
export LESS_TERMCAP_me="${terminfo[sgr0]}"                  # normal (turn off all attributes)
export LESS_TERMCAP_mr="${terminfo[rev]}"                   # reverse
export LESS_TERMCAP_mp="${fg[white]}"                       # protected
export LESS_TERMCAP_mk="${fg[white]}"                       # blank/ invisible
export LESS_TERMCAP_se="${terminfo[sgr0]}"                  # standout end
export LESS_TERMCAP_so="${terminfo[rev]}"                   # standout
export LESS_TERMCAP_ue="${terminfo[sgr0]}"                  # end underline
export LESS_TERMCAP_us="${fg_bold[cyan]}"                   # underline

## terminal configuration
#
case "${TERM}" in
    xterm*|screen*|tmux*)
        case "${OSTYPE}" in
            linux*|darwin*)
                export TERM=linux
                ;;
            *)
                export TERM=xterm-color
                ;;
        esac
        ;;
esac

# set terminal title including current directory
#
export LSCOLORS=gxfxcxdxbxegedabagacad
export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors ${LS_COLORS}

## Default shell configuration
#
# set prompt
#
setup_prompt () {
    psvar=()
    vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
    case ${UID} in
        0)
        PROMPT="%B%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') %{${fg[red]}%}%/#%{${reset_color}%}%b "
        PROMPT2="%B%{${fg[red]}%}%_%%%{${reset_color}%}%b "
        RPROMPT="%{${fg[magenta]}%}%(v|%v|)%{${reset_color}%}"
        SPROMPT="%B%{${fg[red]}%}%r is correct? [N,y,a,e]:%{${reset_color}%} %b"
        ;;
        *)
        PROMPT="%{${fg[yellow]}%}%/%%%{${reset_color}%} "
        PROMPT2="%{${fg[yellow]}%}%_%%%{${reset_color}%} "
        RPROMPT="%{${fg[magenta]}%}%(v|%v|)%{${fg[cyan]}%}[%?]%{${reset_color}%}"
        SPROMPT="%{${fg[yellow]}%}%r is correct? [N,y,a,e]:%{${reset_color}%} "
        [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
            PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
        ;;
    esac
}

# auto change directory
#
setopt auto_cd

# auto push directory
#
setopt auto_pushd
setopt pushd_ignore_dups

# use #, ~, ^ as regexp in filename
#
setopt extended_glob

# expand {a-c} to a b c
#
setopt brace_ccl

# auto fill braket
#
setopt auto_param_keys

# when complement a directory name auto append /
#
setopt auto_param_slash

# auto remove / if unnecessary
#
setopt auto_remove_slash

# when expand filename append / if it's a directory
#
setopt mark_dirs

#
setopt list_types

# auto directory pushd that you can get dirs list by cd -[tab]
#
setopt auto_pushd

# command correct edition before each completion attempt
#
setopt correct

# compacked complete list display
#
setopt list_packed

# no remove postfix slash of command line
#
setopt noautoremoveslash

# no beep sound when complete list displayed
#
setopt nolistbeep

# when exec same name as suspended process, resume it
setopt auto_resume

## Keybind configuration
#
# emacs like keybind (e.x. Ctrl-a goes to head of a line and Ctrl-e goes
#   to end of it)
#
bindkey -e
# bindkey -v

# historical backward/forward search with linehead string binded to ^P/^N
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end
bindkey "^R" history-incremental-pattern-search-backward

# undo/redo
bindkey "^[u" undo
bindkey "^[r" redo

# reverse
bindkey "^[[Z" reverse-menu-complete

# new line but dont exec
bindkey '^J' self-insert-unmeta

# insert last word
# example)
#   % mkdir foo
#   % cd # hit ^]
#   % cd foo
autoload smart-insert-last-word
zle -N insert-last-word smart-insert-last-word
zstyle :insert-last-word match "*([^[:space:]][[:alpha:]/\\]|[[:alpha:]/\\][^[:space:]])*"
bindkey "^]" insert-last-word

## Command history configuration
#
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt hist_ignore_dups     # ignore duplication command history list
#setopt hist_ignore_all_dups
#setopt hist_ignore_space   # ignore command start with space
setopt share_history        # share command history data
setopt hist_reduce_blanks
setopt extended_history     # write time when login/logout to history file

WORDCHARS='*?_[]~&;!#$%^(){}<>'

## Completion configuration
#
fpath=(~/.zsh/zsh-completions ${fpath})
autoload -U compinit
compinit

## zsh editor
#
autoload zed

#zstyle ':completion:*:default' menu select=1

# kill autocompletion
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

# matching: ignore case, -_. are the delimiters
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z} r:|[-_.]=**'

# exclude binary files
zstyle ':completion:*:*:vi:*:*files' ignored-patterns '*.o'
zstyle ':completion:*:*:vi:*:*files' ignored-patterns '*.class'

## Prediction configuration
#
#autoload predict-on
#predict-off

## Movie files efficiently
#
# % ls
# 1.txt 2.txt 3.txt
# % zmv *.txt file-*.txt
# % ls
# file-1.txt file-2.txt file-3.txt
autoload -Uz zmv
#alias zmv='noglob zmv -W'

## Alias configuration
#
# expand aliases before completing
#
setopt complete_aliases     # aliased ls needs if file/dir completions work

alias where="command -v"
alias j="jobs -l"
setopt long_list_jobs

case "${OSTYPE}" in
    *bsd*|darwin*)
        alias ls="ls -GFh"
        alias grep="egrep --color=auto"
        alias df="df -h"
        ;;
    linux*)
        alias ls="ls --color=auto -Fh"
        alias grep="egrep --color=auto --exclude-dir=.svn --exclude-dir=.git"
        alias jman="LC_ALL=ja_JP.UTF-8 MANPATH=/usr/share/man/ja man"
        alias open="gnome-open"
        alias df="df -hT"
        ;;
esac

alias la="ls -A"
alias ll="ls -l"
alias lal="ls -Al"

alias t="tree"
alias ta="tree -a"

alias h=history

alias du="du -h"

#alias pstree="pstree -h"

alias rsync="rsync -P"

alias su="su -l"

alias stop="kill -TSTP"

alias ctags="ctags --exclude=.git --exclude=.svn --exclude=log"

# git
alias g='git'
alias gp='git pull'
alias gl='git log'
alias gt='git tag'
alias gsl='git shortlog'
alias glp='git log -p'
alias gd='git diff'
alias gdh='git diff HEAD'
alias gb='git branch --color'
alias ga='git add'
alias gap='git add -p'
alias gc='git commit -v'
alias gs='git status'
alias gg='git grep --color'
alias gco='git checkout'
alias grm="git status | grep deleted | awk '{print \$3}' | xargs git rm"

# mercurial
alias ha='hg add'
alias hs='hg st'
alias hd='hg diff'
alias hl='hg log'
alias hlp='hg log -p'
alias hgg='hg grep'
alias hc='hg ci'
alias hp='hg pull'
alias hclean='hg st -un | xargs rm'

alias tm='if tmux has-session; then tmux attach-session; else tmux; fi'

# Global aliases -- These don't have to be at the beginning of the command line
#
alias -g L='|less'
alias -g G='|grep'
alias -g X='|xargs'
alias -g H='|head'
alias -g T='|tail'
alias -g W='|wc'
alias -g S='|sort'
alias -g V='|vi -'
#alias -g S='|sed'
#alias -g A='|awk'

case ${OSTYPE} in
    darwin*)
        alias readlink=greadlink
esac

alias wget="wget --no-check-certificate --restrict-file-names=nocontrol"

precmd () {
    setup_prompt
}

# SCM
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats "[%b]"
zstyle ':vcs_info:*' actionformats "[%b|%a]"

preexec () {
    [ ${STY} ] && echo -ne "\ek${1%% *}\e\\"
}

# quote word
# example)
#   % find . -name *.txt     # hit 's' after 'esc'
#   % find . -name '*.txt'
#   % find . -name *.txt     # hit 'd' after 'esc'
#   % find . -name "*.txt"
autoload -U modify-current-argument

_quote-previous-word-in-single() {
    modify-current-argument '${(qq)${(Q)ARG}}'
    zle vi-forward-blank-word
}
zle -N _quote-previous-word-in-single
bindkey '^[s' _quote-previous-word-in-single

_quote-previous-word-in-double() {
    modify-current-argument '${(qqq)${(Q)ARG}}'
    zle vi-forward-blank-word
}
zle -N _quote-previous-word-in-double
bindkey '^[d' _quote-previous-word-in-double


# list-expand at end of the line otherwise delete-char
function _delete-char-or-list-expand() {
    if [[ -z "${RBUFFER}" ]]; then
        # the cursor is at the end of the line
        zle list-expand
    else
        zle delete-char
    fi
}
zle -N _delete-char-or-list-expand
bindkey '^D' _delete-char-or-list-expand

# RVM
[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm
