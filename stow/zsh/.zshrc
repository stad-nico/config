# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
  git
  fzf-zsh-plugin
)

source $ZSH/oh-my-zsh.sh

# User configuration
export PATH="$HOME/.cargo/bin:$PATH"

# FZF configuration
export FZF_CTRL_R_OPTS="--info=inline --prompt='History > ' --preview 'echo {}' --preview-window down:3:hidden:wrap --bind 'ctrl-/:toggle-preview'"
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --color='header:italic'"
export FZF

# NVM configuration
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Tools initialization
if command -v mise &> /dev/null; then
    eval "$($HOME/.local/bin/mise activate zsh)"
fi

if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"
fi

if command -v ng &> /dev/null; then
    source <(ng completion script)
fi

if command -v fzf &> /dev/null; then
    source <(fzf --zsh)
fi

# opencode
export PATH=$HOME/.opencode/bin:$PATH

# Load local secrets/overrides if they exist (e.g. NPM_GITHUB_TOKEN)
if [ -f "$HOME/.zshrc.local" ]; then
    source "$HOME/.zshrc.local"
fi
