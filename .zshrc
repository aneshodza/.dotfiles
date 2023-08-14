source ~/antigen.zsh

[ -e "$HOME/.birthday_reminder/release/birthday-reminder" ] && "$HOME/.birthday_reminder/release/birthday-reminder"

# SPACESHIP_PROMPT_ASYNC=false
# This is needed if the newest version of spaceship is used as async is broken for alacritty

# antigen stuff
antigen use oh-my-zsh
antigen theme spaceship-prompt/spaceship-prompt@v3.16.7
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle junegunn/fzf
antigen apply


. ~/.asdf/asdf.sh

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND="find . -path '*/\.*' -type d -prune -o -type f -print -o -type l -print 2> /dev/null | sed s/^..//"
source ~/.antigen/bundles/junegunn/fzf/shell/key-bindings.zsh
bindkey '^R' fzf-history-widget

# jmp
alias jmpr='cd ~/r'
alias jmpvw='cd ~/c/vw'
alias jmpc='cd ~/c'
alias jmpp='cd ~/p'

# editors
alias mine='rubymine $1'
alias code='open . -a Visual\ Studio\ Code.app'

# git
alias g='git'
alias gitf='g fetch --all --prune'
alias grh='g reset --hard'
alias gc='g checkout'
alias gcd='g checkout develop'
alias gcm='g checkout main'
alias gst='g status'
alias gac='g add -A; g commit -m $1'
alias gp='g push --set-upstream origin $(g rev-parse --abbrev-ref HEAD)'
alias gdm='git branch --merged | grep -v \* | xargs git branch -D' # Deletes all merged branches
alias gdf='git branch | grep -v "develop" | grep -v "master" | xargs git branch -D' # Deletes all non-master and non-develop branches
alias gpl='git pull origin $(git rev-parse --abbrev-ref HEAD)'

function gacp() {
	echo "Committing with message: $1"
	git add -A
	git commit -m $1
	if [ $? -ne 0 ]; then
		echo "Commit failed, most likely due to hooks"
		return 1
	fi
	git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)

  if [ $? -ne 0 ]; then
    echo "Push failed"
    return 2
  fi
}

function gacpp() {
  gacp $1
  gh pr create -a $(gh auth status 2>&1 | grep 'Logged in to github.com as' | awk '{print $7}') -w
}

alias gaap='git add -A; git commit --amend --no-edit; git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)'

# svn
alias gs='git svn'
alias gsrb='git svn rebase'
alias gsacp='git svn add -A; git commit -m $1; git svn dcommit'

# ruby
alias ber='bundle exec rspec'
alias rr='rails routes'
alias repl='rails db:seed:replant'

# vim
function vimf() {
	file=$(fzf --height 40% --reverse)
	if [[ -n "$file" ]]; then
		nvim "$file"
	fi
}
alias vimf='vimf'
alias vim='nvim'

# thefuck
eval $(thefuck --alias)
alias tf='fuck'

# speedtest
alias lag='~/.speedtest/speedtest-cli'

# solargraph
SOLARGRAPH_GLOBAL_CONFIG='~/.dotfiles/.solargraph.yml'

# keybinds
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

# tmux keybinds
function create-tmux_window() { tmux new-window -c "$PWD" }; zle -N create-tmux_window; bindkey '^T' create-tmux_window
function run_exit() { exit }; zle -N run_exit; bindkey '^W' run_exit
function next-window() { tmux next-window }; zle -N next-window; bindkey '^[OP' next-window
function previous-window() { tmux previous-window }; zle -N previous-window; bindkey '^[OQ' previous-window

# misc
alias c='clear'
alias :q='exit'
alias la='ls -a'
alias chosts="sudo nvim /etc/hosts"

# globaldocker alias
alias dc="docker compose -f $HOME/globaldocker/docker-compose.yml"
alias dcu="dc up -d"
alias dcd="dc down"
alias lazydocker="$HOME/.local/bin/lazydocker"
alias ld="lazydocker"
alias dox='docker compose exec app'
alias rb='dox bin/ruby -S'
alias br='dox bin/ruby bin/rails'
alias brs='br s -b 0.0.0.0'
alias rbc='dox bin/rubocop'
alias esl='dox bin/eslint --fix .'
