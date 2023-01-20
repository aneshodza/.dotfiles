eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(/opt/homebrew/bin/brew shellenv)"
source /opt/homebrew/share/antigen/antigen.zsh

# oh-my-zsh and theme
antigen use oh-my-zsh
antigen theme https://github.com/denysdovhan/spaceship-zsh-theme 

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

# git
alias g='git'
alias gitf='g fetch --all --prune'
alias grh='g reset --hard'
alias gc='g checkout'
alias gcd='g checkout develop'
alias gst='g status'
alias gac='g add -A; g commit -m $1'
alias gp='g push'
alias gpl='g pull'

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

# misc
alias c='clear'
alias :q='exit'
alias la='ls -a'

antigen bundle zsh-users/zsh-autosuggestions
antigen bundle tpope/vim-surround
antigen bundle tpope/vim-commentary

antigen apply
