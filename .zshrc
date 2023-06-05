source ~/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Load bundles from the default repo
antigen bundle git
antigen bundle asdf
antigen bundle npm
antigen bundle aws
antigen bundle node
antigen bundle pip
antigen bundle command-not-found
antigen bundle docker
antigen bundle autojump


# Load bundles from external repos
antigen bundle agkozak/zsh-z
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting

# antigen bundle poetry

# Select theme
# antigen theme denysdovhan/spaceship-prompt

# Tell Antigen that you're done.
antigen apply


# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias vim="nvim"
alias cat="bat"
alias cc="clear"

alias activate_poetry="source \"\$(poetry env list --full-path | grep Activated | cut -d' ' -f1 )/bin/activate\""
alias por="poetry run"
# this alias is needed due to vim and tmux navigation not working inside virtual envs 
# https://github.com/christoomey/vim-tmux-navigator/issues/230
alias prn="poetry run nvim"
alias dcup="docker compose up -d"
alias dcd="docker compose down"

alias tmux_colors='for x in {0..255}; do  printf "\x1b[38;5;${x}mcolor%-5i\x1b[0m" $x ; if ! (( ($x + 1 ) % 8 )); then echo ; fi ; done'

eval "$(starship init zsh)"
eval "$(github-copilot-cli alias -- "$0")"
if command -v tmux >/dev/null; then
	[[ ! $TERM =~ screen ]] && [ -z $TMUX ] && tmux new-session -A -s main
     	# check if we have been switched to light, else go dark
	# [[ ! $(tmux show-environment | grep THEME) =~ 'THEME=light' ]] &&
	# 	tmux set-environment THEME dark
fi

export PATH="$HOME/.local/bin:$PATH"


# # check for PNPM_HOME in path 
# keeps pnpm updated don't comment this out
export PNPM_HOME="/Users/leoroese/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# pnpm
export PNPM_HOME="/Users/leoroese/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
