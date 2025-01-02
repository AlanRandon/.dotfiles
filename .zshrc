PATH=$PATH:$HOME/.fzf/bin:$HOME/bin:$HOME/.zvm/bin:$HOME/.zvm/self:$HOME/.npm-global/bin
# export SWAYSOCK=$(ls /run/user/1000/sway-ipc.* | head -n 1)
which hyprctl &> /dev/null && export HYPRLAND_INSTANCE_SIGNATURE=$(hyprctl -j instances | jq -r '.[0].instance')

if [[ $TERM_PROGRAM != "vscode" ]] && [ -z $TMUX ]; then
	session=$(tmux list-sessions -F "#{session_id}" | head -1)
	if [ -z $session ]; then
		exec tmux new-session
	else
		exec tmux attach-session -t $session
	fi
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit light starship/starship

zinit ice wait lucid blockf atload"zicompinit; zicdreplay"
zinit light zsh-users/zsh-completions

zinit ice wait lucid atload'_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

zinit ice wait lucid
zinit light chisui/zsh-nix-shell

zinit ice wait lucid
zinit snippet OMZP::git

zinit ice wait lucid
zinit light zsh-users/zsh-syntax-highlighting

zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode

zinit cdreplay -q

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt autocd

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no

alias vim="nvim"
alias nd="nix develop"

export EDITOR=nvim
export TERMINAL=ghostty
export BROWSER=firefox

[ -f $HOME/.cargo/env ] && . "$HOME/.cargo/env"
[[ ! -r $HOME/.opam/opam-init/init.zsh ]] || source $HOME/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

command -v fzf &> /dev/null && eval "$(fzf --zsh)"
