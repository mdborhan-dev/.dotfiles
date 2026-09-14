# ══════════════════════════════════════════════════════════════════
#  ~/.zshrc — Fedora XFCE Configuration
# ══════════════════════════════════════════════════════════════════

# ══════════════════════════════════════════════════════════════════
#  HISTORY
# ══════════════════════════════════════════════════════════════════
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000

setopt HIST_IGNORE_DUPS        # Don't record duplicate consecutive commands
setopt HIST_IGNORE_ALL_DUPS    # Remove older duplicate entries
setopt HIST_IGNORE_SPACE       # Don't record commands starting with space
setopt HIST_SAVE_NO_DUPS       # Don't write duplicates to history file
setopt HIST_REDUCE_BLANKS      # Remove superfluous blanks
setopt HIST_VERIFY             # Show expanded history before executing
setopt SHARE_HISTORY           # Share history between sessions
setopt EXTENDED_HISTORY        # Save timestamp and duration
setopt INC_APPEND_HISTORY      # Write to history file immediately

# ══════════════════════════════════════════════════════════════════
#  ZSH OPTIONS
# ══════════════════════════════════════════════════════════════════
setopt AUTO_CD                 # cd by typing directory name
setopt AUTO_PUSHD              # Push old directory onto stack on cd
setopt PUSHD_IGNORE_DUPS       # Don't push duplicates onto stack
setopt CORRECT                 # Suggest corrections for mistyped commands
setopt INTERACTIVE_COMMENTS    # Allow # comments in interactive shell
setopt EXTENDED_GLOB           # Extended glob patterns
setopt NO_BEEP                 # Silence all bells

# ══════════════════════════════════════════════════════════════════
#  FASTFETCH
# ══════════════════════════════════════════════════════════════════
if command -v fastfetch &>/dev/null; then
  fastfetch
fi

# ══════════════════════════════════════════════════════════════════
#  COMPLETION
# ══════════════════════════════════════════════════════════════════
autoload -Uz compinit
compinit

# Completion styling
zstyle ':completion:*' menu select                          # Arrow-key menu
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'        # Case-insensitive matching
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"    # Colorize completions
zstyle ':completion:*' group-name ''                       # Group completions
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:warnings' format '%F{red}No matches: %d%f'
zstyle ':completion:*' rehash true                         # Auto-find new executables

# ══════════════════════════════════════════════════════════════════
#  PLUGINS
# ══════════════════════════════════════════════════════════════════

# ── Syntax Highlighting ──────────────────────────────────────────
# Must be sourced before autosuggestions
if [[ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# ── Autosuggestions ──────────────────────────────────────────────
if [[ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
elif [[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Autosuggestion settings
ZSH_AUTOSUGGEST_STRATEGY=(history completion)   # Use both history and completion
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20              # Don't suggest for long buffers
ZSH_AUTOSUGGEST_USE_ASYNC=1                     # Non-blocking suggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#8a8a8a'   # Grey suggestions

# ══════════════════════════════════════════════════════════════════
#  KEY BINDINGS
# ══════════════════════════════════════════════════════════════════
bindkey -e                                    # Emacs keybindings

# Navigation
bindkey '^[[1;5C' forward-word               # Ctrl+Right: forward word
bindkey '^[[1;5D' backward-word              # Ctrl+Left: backward word
bindkey '^[[H'    beginning-of-line          # Home key
bindkey '^[[F'    end-of-line               # End key
bindkey '^[[3~'   delete-char               # Delete key

# History search with arrow keys
bindkey '^[[A'    up-line-or-search          # Up arrow: search history
bindkey '^[[B'    down-line-or-search        # Down arrow: search history
bindkey '^R'      history-incremental-search-backward

# Accept autosuggestion
bindkey '^ '      autosuggest-accept         # Ctrl+Space
bindkey '^[[C'    forward-char              # Right arrow at end accepts

# ══════════════════════════════════════════════════════════════════
#  PATH
# ══════════════════════════════════════════════════════════════════
typeset -U path  # Deduplicate PATH entries
path=(
  $HOME/.local/bin
  $HOME/bin
  $path
)
export PATH

# ══════════════════════════════════════════════════════════════════
#  ENVIRONMENT
# ══════════════════════════════════════════════════════════════════
export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'
export LESS='-R --mouse --wheel-lines=3'

# ══════════════════════════════════════════════════════════════════
#  ALIASES
# ══════════════════════════════════════════════════════════════════

# ── Navigation ───────────────────────────────────────────────────
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias -- -='cd -'            # Go to previous directory

# ── Listing ──────────────────────────────────────────────────────
if command -v eza &>/dev/null; then
  alias ls='eza --color=always --icons --group-directories-first'
  alias ll='eza -la --color=always --icons --git --group-directories-first'
  alias la='eza -la --color=always --icons'
  alias lt='eza --tree --color=always --icons --level=2'
else
  alias ls='ls --color=auto -h'
  alias ll='ls -lah'
  alias la='ls -lah'
fi

# ── Editor ───────────────────────────────────────────────────────
alias v='nvim'
alias vi='nvim'
alias vim='nvim'

# ── Git ──────────────────────────────────────────────────────────
alias g='git'
alias gs='git status'
alias ga='git add'
alias gaa='git add .'
alias gc='git commit -m'
alias gp='git push'
alias gpl='git pull'
alias gl='git log --oneline --graph --decorate'
alias gd='git diff'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gb='git branch'

# ── System ───────────────────────────────────────────────────────
alias df='df -h'
alias du='du -sh'
alias free='free -h'
alias ports='ss -tulanp'
alias mem='ps auxf | sort -nr -k 4 | head -10'   # Top 10 memory hogs
alias cpu='ps auxf | sort -nr -k 3 | head -10'   # Top 10 CPU hogs

# ── Safety nets ──────────────────────────────────────────────────
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# ── Package management (Fedora) ──────────────────────────────────
alias update='sudo dnf update'
alias install='sudo dnf install'
alias remove='sudo dnf remove'
alias search='dnf search'

# ── Misc ─────────────────────────────────────────────────────────
alias reload='source ~/.zshrc && echo "Config reloaded ✓"'
alias path='echo $PATH | tr ":" "\n"'
alias clr='clear'
alias h='history | tail -50'
alias hg='history | grep'         # Search history
alias json='python3 -m json.tool' # Pretty-print JSON

# Use bat instead of cat if available
if command -v bat &>/dev/null; then
  alias cat='bat --paging=never'
  alias catp='bat'                   # bat with pager
elif command -v batcat &>/dev/null; then  # Fedora names it batcat
  alias cat='batcat --paging=never'
  alias catp='batcat'
fi

# ══════════════════════════════════════════════════════════════════
#  FUNCTIONS
# ══════════════════════════════════════════════════════════════════

# Make a directory and cd into it
mkcd() { mkdir -p "$1" && cd "$1" }

# Extract any archive
extract() {
  if [[ -f "$1" ]]; then
    case "$1" in
      *.tar.bz2)   tar xjf "$1"     ;;
      *.tar.gz)    tar xzf "$1"     ;;
      *.tar.xz)    tar xJf "$1"     ;;
      *.bz2)       bunzip2 "$1"     ;;
      *.rar)       unrar e "$1"     ;;
      *.gz)        gunzip "$1"      ;;
      *.tar)       tar xf "$1"      ;;
      *.tbz2)      tar xjf "$1"     ;;
      *.tgz)       tar xzf "$1"     ;;
      *.zip)       unzip "$1"       ;;
      *.Z)         uncompress "$1"  ;;
      *.7z)        7z x "$1"        ;;
      *)           echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Quick backup of a file
bak() { cp "$1"{,.bak} && echo "Backed up $1 → $1.bak" }

# Show directory size sorted
dsize() { du -sh "${1:-.}"/* | sort -h }

# Search for a process
psg() { ps aux | grep -i "$1" | grep -v grep }

# Quick HTTP server in current dir
serve() { python3 -m http.server "${1:-8000}" }

# ══════════════════════════════════════════════════════════════════
#  OPTIONAL TOOLS (uncomment if installed)
# ══════════════════════════════════════════════════════════════════

# ── FZF ──────────────────────────────────────────────────────────
if command -v fzf &>/dev/null; then
  source <(fzf --zsh)
  
  export FZF_DEFAULT_OPTS="
    --height=40%
    --layout=reverse
    --border=rounded
    --preview-window=right:60%:wrap"
  
  # Use fd instead of find (Fedora: fd-find)
  if command -v fdfind &>/dev/null; then
    export FZF_DEFAULT_COMMAND='fdfind --type f --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  elif command -v fd &>/dev/null; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  fi
fi

# ── Zoxide ───────────────────────────────────────────────────────
if command -v zoxide &>/dev/null; then
  eval "$(zoxide init zsh)"
fi

# ══════════════════════════════════════════════════════════════════
#  PROMPT — Starship
# ══════════════════════════════════════════════════════════════════
eval "$(starship init zsh)"
export PATH="$HOME/.local/bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
