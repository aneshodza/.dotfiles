# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/antigen.zsh

[ -e "$HOME/.birthday_reminder/release/birthday-reminder" ] && "$HOME/.birthday_reminder/release/birthday-reminder"

# antigen stuff
antigen use oh-my-zsh
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle junegunn/fzf

antigen theme romkatv/powerlevel10k

antigen apply

. ~/.asdf/asdf.sh

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND="find . -path '*/\.*' -type d -prune -o -type f -print -o -type l -print 2> /dev/null | sed s/^..//"
source ~/.antigen/bundles/junegunn/fzf/shell/key-bindings.zsh
bindkey '^R' fzf-history-widget
bindkey '^T' fzf-file-widget

# asdf
alias asdfi="cp RUBY_VERSION .ruby-version && asdf install"

# git
alias g='git'
alias gitf='g fetch --all --prune'
alias grh='g reset --hard'
alias gc='g checkout'
alias gcd='g checkout develop'
alias gcm='git checkout $(git show-ref --verify --quiet refs/heads/main && echo main || echo master)'
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
  gh pr create
}

alias gaap='git add -A; git commit --amend --no-edit; git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)'
alias gss='if [[ -z $(git stash list) ]]; then echo "Nothing stashed"; else echo "--------------------------------------"; for stash in $(git stash list --format="%gd"); do echo -e "\e[34m\e[107m$stash\e[0m has changed the following files:"; echo -e "$(git stash show $stash)"; echo "--------------------------------------"; done; fi'

# svn
alias gs='git svn'
alias gsrb='git svn rebase'
function gsacp() {
	echo "Committing with message: $1"
  git add .
  git commit -m $1
	if [ $? -ne 0 ]; then
		echo "Commit failed, most likely due to hooks"
		return 1
	fi
  git svn dcommit
}

# ruby
alias ber='bundle exec rspec'
alias rr='rails routes'
alias repl='rails db:seed:replant'

# vim
function vimf() {
  file=$(git ls-files --cached --others --exclude-standard | fzf --height 40% --reverse)
  if [[ -n "$file" ]]; then
    nvim "$file"
  fi
}
alias vim='nvim'
alias vimdiff='nvim -d'

# Start an empty nvim instance
alias evim='nvim -u NONE'
function evimf() {
  file=$(git ls-files --cached --others --exclude-standard | fzf --height 40% --reverse)
  if [[ -n "$file" ]]; then
    evim "$file"
  fi
}

# thefuck
eval $(thefuck --alias)
alias tf='fuck'

# speedtest
alias lag='~/.speedtest/speedtest-cli'

# solargraph
export SOLARGRAPH_GLOBAL_CONFIG='~/.dotfiles/.solargraph.yml'

# keybinds
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

# misc
alias c='clear'
alias :q='exit'
alias la='ls -lahs'
alias chosts="sudo nvim /etc/hosts"
alias pumkill="kill $(pgrep -f puma)"
export EDITOR=nvim
export VISUAL=nvim
export SVN_EDITOR=nvim
function crun() {
    if [[ $# -lt 1 ]]; then
        echo "Usage: crun <source_file.c> [params...]"
        return 1
    fi

    local src_file="$1"
    shift

    gcc "$src_file" -o a.out && ./a.out "$@"
    local exit_code=$?
    rm -f a.out

    return $exit_code
}

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

function ruby() {
    # Check if Ruby exists in the Docker container
    local docker_ruby_version=$(docker compose exec app bin/ruby -v 2>/dev/null)

    # If the Docker command failed or didn't return Ruby version, use local Ruby
    if [[ $? -ne 0 || ! $docker_ruby_version =~ "ruby" ]]; then
        command ruby "$@"
    else
        docker compose exec app bin/ruby "$@"
    fi
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
if [[ -f ~/.p10k.zsh ]]; then
  source ~/.p10k.zsh
elif [[ -f ~/.dotfiles/.p10k.zsh ]]; then
  source ~/.dotfiles/.p10k.zsh
fi

# c#
export DOTNET_ROOT="$HOME/.asdf/installs/dotnet-core/9.0.304"
export PATH="$DOTNET_ROOT:$DOTNET_ROOT/tools:$HOME/.dotnet/tools:$PATH"


# Load Angular CLI autocompletion.
source <(ng completion script)
