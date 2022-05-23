#--- OH-MY-ZSH --------------------------------------------------------------
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="spaceship"

ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

plugins=(
	zsh-autosuggestions
	zsh-syntax-highlighting
	direnv
	dirhistory
	z
	fzf
	fzf
	fzf-tab
	fzf-marks
	git
	docker
	docker-compose
	npm
	aliases
)
#---------------------------------------------------------------------------



# ZSH ----------------------------------------------------------------------
ZSH_AUTOSUGGEST_USE_ASYNC="true"
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=50
#---------------------------------------------------------------------------



# Prompt spaceship ---------------------------------------------------------
SPACESHIP_DOCKER_SHOW=false
SPACESHIP_TIME_SHOW=true
SPACESHIP_DIR_TRUNC_REPO=true
#---------------------------------------------------------------------------



#--- OPTIONS --------------------------------------------------------------
setopt BANG_HIST              # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY       # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY     # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY          # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS       # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS   # Delete old recorded entry if new entry is a duplicate.
setopt HIST_SAVE_NO_DUPS      # Don't write duplicate entries in the history file.
setopt HIST_FIND_NO_DUPS      # Do not display a line previously found.
setopt HIST_IGNORE_SPACE      # Don't record an entry starting with a space.
setopt HIST_REDUCE_BLANKS     # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY            # Don't execute immediately upon history expansion.
#---------------------------------------------------------------------------



#--- EXPORT --------------------------------------------------------------
LANG='en_US.UTF-8'
LC_ALL='en_US.UTF-8'
LC_COLLATE="C"
VISUAL="vim"
EDITOR="vim"
TERM="xterm-256color"

HISTSIZE=5000
SAVEHIST=5000


MANPAGER="sh -c 'col -bx | bat -l man -p'"
PAGER='bat -p'

#FZF_BASE=~/.zsh/fzf
FZF_DEFAULT_COMMAND='fd --type file --type directory --absolute-path --follow --hidden --exclude .git --exclude node_modules --color=always'
FZF_DEFAULT_OPTS="--ansi"

TIPZ_TEXT='💡 '
VOLTA_HOME="$HOME/.volta"

BROWSER=microsoft-edge

fpath+=${ZSH_CUSTOM}/plugins/zsh-completions/src

path+=($VOLTA_HOME/bin $HOME/.local/bin $HOME/.cargo/bin $HOME/go/bin)
#---------------------------------------------------------------------------



source $ZSH/oh-my-zsh.sh



#--- ALIASES --------------------------------------------------------------
alias cd..="cd .."
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias -- -="cd -"

alias grep="grep --color=auto"
alias sgrep='grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS} '
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"
alias less="less -R"

alias dud='du -d 1 -h'
alias duf='du -sh *'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'

alias view='bat'
alias cat='bat -p'
alias more='bat -p'

# alias ls='ls -l -h -v --group-directories-first --time-style=+"%Y-%m-%d %H:%M" --color=auto -F --tabsize=0 --literal --show-control-chars --color=always --human-readable'
# alias la='ls -a'
alias ls='exa -la -L 3 --git --group-directories-first --ignore-glob="node_modules|.git" --icons'
alias la=ls

alias vi=vim
alias nano=vim


alias path='echo -e ${PATH//:/\\n}'
alias ssh-add='eval "$(ssh-agent -s)" && ssh-add'

alias lazydocker='docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock -v /home/florent/docker/lazydocker//config:/.config/jesseduffield/lazydocker lazyteam/lazydocker'
alias dive='docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock wagoodman/dive:latest'

#alias man=cheat

# alias keepalive-vdi="xdotool key --window $(comm -12 <(xdotool search --name 'FR09540462W' | sort) <(xdotool search --class 'Wfica' | sort)) --delay 300000 --repeat 288 space"
#---------------------------------------------------------------------------



#---LOAD EXTERNAL FILES  --------------------------------------------------------------
#---------------------------------------------------------------------------



#---FUNCTIONS (move to bin ?) --------------------------------------------------------------
# Create a new directory and enter it
function mkcd() {
   mkdir -p "$@" && cd "$_";
}

# Search text in file content
function find-in-files() {
    grep -rnw --exclude-dir={.git,node_modules,coverage,__snapshots__,migrations,venv,bower_components} . -e $1;
}

# Determine size of a file or total size of a directory
function fs() {
	if du -b /dev/null > /dev/null 2>&1; then
		local arg=-sbh;
	else
		local arg=-sh;
	fi
	if [[ -n "$@" ]]; then
		du $arg -- "$@";
	else
		du $arg .[^.]* ./*;
	fi;
}
#---------------------------------------------------------------------------



#--- USER CONFIGURATION --------------------------------------------------------------
# Ctrl+Space to accept suggestion from zsh-autosuggestions (MUST come after sourcing oh my zsh stuff see https://github.com/zsh-users/zsh-autosuggestions/issues/471#issuecomment-573500890)
bindkey '^ ' autosuggest-accept

# Make zsh know about hosts already accessed by SSH
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

# Improve paste performances https://github.com/zsh-users/zsh-syntax-highlighting/issues/295#issuecomment-214581607
zstyle ':bracketed-paste-magic' active-widgets '.self-*'

# Do not sort with fzf-tab when doing "git checkout [tab]"
zstyle ':completion:*:git-checkout:*' sort false

# do not suggest . and .. when doing cd <TAB>
# for some reason I have to put it last
# zstyle ':completion:*' special-dirs false

# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'

# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'

# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'

# give a preview of commandline arguments when completing `kill`
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview '[[ $group == "[process ID]" ]] && ps --pid=$word -o cmd --no-headers -w -w'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap

zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'

zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' fzf-preview 'echo ${(P)word}'

# it is an example. you can change it
zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview \
	'git diff $word | delta'
zstyle ':fzf-tab:complete:git-log:*' fzf-preview \
	'git log --color=always $word'
zstyle ':fzf-tab:complete:git-help:*' fzf-preview \
	'git help $word | bat -plman --color=always'
zstyle ':fzf-tab:complete:git-show:*' fzf-preview \
	'case "$group" in
	"commit tag") git show --color=always $word ;;
	*) git show --color=always $word | delta ;;
	esac'
zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview \
	'case "$group" in
	"modified file") git diff $word | delta ;;
	"recent commit object name") git show --color=always $word | delta ;;
	*) git log --color=always $word ;;
	esac'

# zstyle ':fzf-tab:complete:tldr:argument-1' fzf-preview 'tldr --color always $word'  
#---------------------------------------------------------------------------
