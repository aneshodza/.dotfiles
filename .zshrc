eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(/opt/homebrew/bin/brew shellenv)"
source /opt/homebrew/share/antigen/antigen.zsh

antigen use oh-my-zsh
antigen theme https://github.com/denysdovhan/spaceship-zsh-theme 
antigen apply

. $(brew --prefix asdf)/libexec/asdf.sh

# visuals
ZSH_THEME="Monocraft"

# plugins
plugins=(fzf zsh-autosuggestions)

# editors
alias mine='rubymine $1'
alias code='open . -a Visual\ Studio\ Code.app'

# git
alias g='git'
alias gitf='g fetch --all --prune'
alias gcd='g checkout develop'
alias gst='g status'

# ruby
alias ber='bundle exec rspec'
alias rr='rails routes'
alias repl='rails db:seed:replant'

# vim
alias vimf='vim $(fzf)'
