export PATH="${PATH}:${HOME}/.local/bin"

export DISABLE_AUTO_TITLE='true'
# export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix'

setopt NO_CASE_GLOB

export EDITOR=neovim

# fcd() {
#   local dir
#   dir=$(find ${1:-.} -type d \( -name 'node_modules' -o -path '*/.*' \) -prune -o -print 2> /dev/null | fzf +m) && cd "$dir"
# }


# Starship
eval "$(starship init zsh)"

# zoxide
eval "$(zoxide init zsh)"

# aliases
alias v="nvim"
alias v.="nvim ."
alias vim="nvim"
alias vi="nvim"
alias ff='fzf'
alias lg='lazygit'
alias e='exit'
alias c='clear'
alias bud='brew update'
alias bug='brew upgrade'
alias bo='brew outdated --verbose'
alias pi='pnpm install'
alias pd='pnpm dev'
alias po='pnpm outdated -r'
alias pb='pnpm build'
alias pc='pnpm clean && pnpm clean:workspaces'
alias azs='azurite -l $TMPDIR/azurite -s'

if [[ -x "$(command -v bat)" ]]; then
	alias cat="bat"
fi

if [[ -x "$(command -v eza)" ]]; then
	alias ll="eza --icons --git --long --all"
	alias ls="eza --icons --git --long"
else
	alias ll="ls -alFGH"
	alias ls="ls -G"
fi

alias cd='z'
alias ..='cd ..'
alias ....='cd ../..'
alias ......='cd ../../..'
alias grep='grep --color=auto'

# .cfg bare repo alias
# alias config='/usr/bin/git --git-dir=/Users/rms/.cfg/ --work-tree=/Users/rms'
# alias cs='config status -s'
# alias cdi='()config diff $1'

#zsh plugins
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-hightlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-completions/zsh-completions.plugin.zsh
# source ~/.zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# pnpm
export PNPM_HOME="/Users/rms/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

# thefuck alias setup
eval $(thefuck --alias)
eval $(thefuck --alias fk)

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

# -- Use fd instead of fzf --
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

# bun completions
[ -s "/Users/rms/.bun/_bun" ] && source "/Users/rms/.bun/_bun"

# hook direnv into shell
eval "$(direnv hook zsh)"
