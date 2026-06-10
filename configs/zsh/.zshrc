# Path
export PATH="$HOME/.local/bin:$PATH"

# Android SDK
export ANDROID_HOME="$HOME/Android/Sdk"
export ANDROID_SDK_ROOT="$ANDROID_HOME"
export PATH="$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools:$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"

# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt sharehistory
setopt hist_ignore_dups
setopt hist_ignore_space
setopt inc_append_history

# Completion
autoload -Uz compinit
compinit

# Better defaults
setopt autocd
setopt correct
setopt interactive_comments

# Keybindings
bindkey -e

# Tools
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Aliases
alias ll='eza -la --icons --git'
alias la='eza -la --icons'
alias ls='eza --icons'
alias tree='eza --tree --icons'
alias cat='bat'
alias grep='grep --color=auto'
alias ..='cd ..'
alias ...='cd ../..'

# Projects
alias projects='cd /data/Projects'
alias mobile='cd /data/Projects/mobile'
alias web='cd /data/Projects/web'
alias backend='cd /data/Projects/backend'

# Pacman / Paru helpers
alias update='paru -Syu'
alias pacsearch='pacman -Ss'
alias pacinfo='pacman -Qi'

# Safer bat helpers
alias ccat='bat'
alias preview='bat --style=numbers --color=always'

# FZF
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'

export FZF_DEFAULT_OPTS='
--height 40%
--layout=reverse
--border
--preview "bat --style=numbers --color=always --line-range :200 {}"
'

# Development aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --decorate --all -20'
alias gco='git checkout'
alias gcb='git checkout -b'

alias nr='npm run'
alias ni='npm install'
alias nd='npm run dev'

alias pr='pnpm run'
alias pi='pnpm install'
alias pd='pnpm dev'
alias pb='pnpm build'

alias py='python'
alias venv='python -m venv .venv'
alias activate='source .venv/bin/activate'

alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'
alias dc='docker compose'
alias dcu='docker compose up'
alias dcud='docker compose up -d'
alias dcd='docker compose down'

alias cls='clear'
alias path='echo $PATH | tr ":" "\n"'

# FZF keybindings and completion
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh

# Mini fastfetch on terminal start
if [[ $- == *i* ]] && command -v fastfetch >/dev/null 2>&1; then
  fastfetch --config ~/.config/fastfetch/mini.jsonc
fi

# Data shortcuts
alias data='cd /data'
alias docs='cd /data/Documents'
alias downloads='cd /data/Downloads'
alias media='cd /data/Media'
alias backups='cd /data/Backups'
alias tempdata='cd /data/Temp'

# Project shortcuts
alias projects='cd /data/Projects'
alias mobile='cd /data/Projects/mobile'
alias web='cd /data/Projects/web'
alias backend='cd /data/Projects/backend'
alias learning='cd /data/Projects/learning'
alias experiments='cd /data/Projects/experiments'

# VS Code project shortcuts
alias codeprojects='code /data/Projects'
alias codefocus='code /data/Projects/mobile/focusflow'
alias codesethero='code /data/Projects/mobile/sethero'
alias codeweb='code /data/Projects/web'
alias codebackend='code /data/Projects/backend'
