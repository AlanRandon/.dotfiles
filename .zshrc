# zmodload zsh/zprof
PATH=$PATH:$HOME/.npm-global/bin
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

export EDITOR=nvim
export TERMINAL=ghostty
export BROWSER=firefox

zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit light starship/starship

zinit ice wait lucid
zinit light chisui/zsh-nix-shell

zinit ice wait lucid
zinit snippet OMZP::git

zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
 blockf \
    zsh-users/zsh-completions \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
 pick"zsh/fzf-zsh-completion.sh" \
    lincheney/fzf-tab-completion

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

ZSH_AUTOSUGGEST_IGNORE_WIDGETS=(fzf_completion)
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
zvm_after_init() {
	zvm_define_widget autosuggest-accept
	zvm_bindkey viins '^I' autosuggest-accept
	zvm_define_widget fzf_completion 
	zvm_bindkey viins '^ ' fzf_completion
}

alias vim="nvim"
alias nd="nix develop -c zsh"
alias l="eza --long --icons --header --git"
alias lt="l --tree"
alias m="~/scripts/fzfman"

gcme() { git clone https://github.com/AlanRandon/$@ }

[ -f $HOME/.cargo/env ] && . "$HOME/.cargo/env"
[[ ! -r $HOME/.opam/opam-init/init.zsh ]] || source $HOME/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

command -v fzf &> /dev/null && eval "$(fzf --zsh)"
# zprof | less
