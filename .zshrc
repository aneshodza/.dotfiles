eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(/opt/homebrew/bin/brew shellenv)"
source /opt/homebrew/share/antigen/antigen.zsh

# oh-my-zsh and theme
antigen use oh-my-zsh
antigen theme https://github.com/denysdovhan/spaceship-zsh-theme 
SPACESHIP_BATTERY_SHOW=false

. $(brew --prefix asdf)/libexec/asdf.sh

# plugins
plugins=(fzf zsh-autosuggestions)

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND="find . -path '*/\.*' -type d -prune -o -type f -print -o -type l -print 2> /dev/null | sed s/^..//"

# jmp
alias jmpr='cd ~/r'
alias jmpvw='cd ~/c/vw'
alias jmpc='cd ~/c'
alias jmpp='cd ~/p'

# editors
alias mine='rubymine $1'
alias code='open . -a Visual\ Studio\ Code.app'

# run
function runner() {
	if [[ -f "bin/dev" ]]; then
		bin/dev
	elif [[ -f "bin/run" ]]; then
		bin/run
	elif [[ -f "bin/start" ]]; then
		bin/start
	else
		echo "No bin/dev, bin/run, or bin/start found"
		if [ -z "$1" ]; then
			echo "Give a language/framework as an argument to run a default command"
			return 1
		elif [[ "$1" == "ruby" ]]; then
			bundle exec rails s
		elif [[ "$1" == "react" ]]; then
			npm start
		else
			echo "No default command found for $1"
			return 2
		fi
	fi
}
alias run='runner $1'

# git
alias g='git'
alias gitf='g fetch --all --prune'
alias grh='g reset --hard'
alias gc='g checkout'
alias gcd='g checkout develop'
alias gst='g status'
alias gac='g add -A; g commit -m $1'
alias gp='g push --set-upstream origin $(g rev-parse --abbrev-ref HEAD)'
alias gdm='git branch --merged | grep -v \* | xargs git branch -D' # Deletes all merged branches
alias gdf='git branch | grep -v "develop" | grep -v "master" | xargs git branch -D' # Deletes all non-master and non-develop branches
alias gpl='g pull'

function gacp() {
	echo "Committing with message: $1"
	git add -A
	git commit -m $1
	git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)
}
alias gacp='gacp $1'

# ruby
alias ber='bundle exec rspec'
alias rr='rails routes'
alias repl='rails db:seed:replant'

# vim
function vimf() {
	file=$(fzf --height 40% --reverse)
	if [[ -n "$file" ]]; then
		vim "$file"
	fi
}
alias vimf='vimf'

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

# misc
alias c='clear'
alias :q='exit'
alias la='ls -a'

antigen bundle zsh-users/zsh-autosuggestions
antigen bundle tpope/vim-surround
antigen bundle tpope/vim-commentary

antigen apply
