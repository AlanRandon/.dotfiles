# zmodload zsh/zprof
PATH=$PATH:$HOME/.npm-global/bin:$HOME/.local/bin:
which hyprctl &> /dev/null && export HYPRLAND_INSTANCE_SIGNATURE=$(hyprctl -j instances | jq -r '.[0].instance')

# [[ $TERM_PROGRAM != "vscode" ]] &&
if [ -z $TMUX ]; then
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

zinit wait lucid for \
	atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
		zdharma-continuum/fast-syntax-highlighting \
	blockf \
		zsh-users/zsh-completions \
	atload"!_zsh_autosuggest_start" \
		zsh-users/zsh-autosuggestions \
	pick"zsh/fzf-zsh-completion.sh" \
		lincheney/fzf-tab-completion \
		OMZP::git \

zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode

for f in zvm_backward_kill_region zvm_yank zvm_replace_selection zvm_change_surround_text_object zvm_vi_delete zvm_vi_change zvm_vi_change_eol; do
  eval "$(echo "_$f() {"; declare -f $f | tail -n +2)"
  eval "$f() { _$f; echo -en \$CUTBUFFER | wl-copy -n }"
done

for f in zvm_vi_put_after zvm_vi_put_before; do
  eval "$(echo "_$f() {"; declare -f $f | tail -n +2)"
  eval "$f() { CUTBUFFER=\$(wl-paste); _$f; zvm_highlight clear }"
done

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
alias zb="zig build"
alias zbr="zig build run"
alias mkproj="~/scripts/mkproj"

gcme() { git clone https://github.com/AlanRandon/$@ }

[ -f $HOME/.cargo/env ] && . "$HOME/.cargo/env"
[[ ! -r $HOME/.opam/opam-init/init.zsh ]] || source $HOME/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

command -v fzf &> /dev/null && eval "$(fzf --zsh)"

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
# zprof | less
