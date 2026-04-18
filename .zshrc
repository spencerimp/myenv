# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git z tmux docker)

source $ZSH/oh-my-zsh.sh

export TERM="xterm-256color"
alias mem="free -g | awk '/Mem:/{print $2}'"
alias gitdiff='git diff --color | diff-so-fancy'
export EDITOR=vim

# for fun
alias ptt="ssh bbsu@ptt.cc"
# showing that you are using screen or not
if [ -n "$STY" ]; then export PS1="($STY) $PS1"; fi

alias dps="docker ps"
alias dmg="docker images"
alias docker-arch-ps='for i in `docker ps --format "{{.Image}}"` ; do docker image inspect $i --format "$i -> {{.Architecture}} : {{.Os}}" ;done';

drun() {
   usage="Run a Docker image (specified in the first argument) with bash shell. The container will be deleted once detached"
   if [ "$#" -eq 0 ]
   then
       echo $usage
       return
   fi
   docker run --rm -it --entrypoint /bin/bash "$1"
}
dex() {
   usage="Execute bash from a container (specified in the first argument)."
   if [ "$#" -eq 0 ]
   then
       echo $usage
       return
   fi
    docker exec -it "$1" bash
}

ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="▶"
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""

# after installing openblas using homebrew
export LDFLAGS="-L/opt/homebrew/opt/openblas/lib"
export CPPFLAGS="-I/opt/homebrew/opt/openblas/include"

# worktree
worktree-tmux() {
  if [[ $# -eq 0 ]]; then
    cat <<'EOF'
worktree-tmux — Create a git worktree + named tmux session, then run a command

USAGE
  worktree-tmux <branch> [base-branch] [-c <command>]

ARGUMENTS
  branch        Branch to create or reuse.
  base-branch   Where to branch from. Defaults to HEAD.

OPTIONS
  -c <command>  Command to run in the session. Defaults to $SHELL if omitted.

EXAMPLES
  worktree-tmux feature/my-task                          # bare shell
  worktree-tmux feature/my-task -c claude                # launch claude
  worktree-tmux feature/my-task -c "gh copilot suggest"  # copilot CLI
  worktree-tmux fix/bug-123 main -c nvim                 # off main, open nvim
  worktree-tmux spike/idea HEAD -c "npm i && claude"     # multi-step

WHAT IT DOES
  1. Creates a git worktree at <parent>/<repo>-<branch> (sibling of current repo)
  2. Creates a tmux session named after the branch (/ → -)
  3. Runs the given command (or $SHELL) inside the worktree
  If the session already exists, attaches to it instead.

SEE ALSO
  worktree-tmux-rm <branch>    Tear down the session and worktree when done
  cc-worktree <branch> [base]  Shorthand: runs claude as the command
  cwt <branch> [editor]        Open an existing worktree in an editor
EOF
    return 0
  fi

  local branch="$1"; shift
  local base="HEAD"
  local cmd="$SHELL"

  if [[ $# -gt 0 && "$1" != "-c" ]]; then
    base="$1"; shift
  fi

  if [[ "$1" == "-c" ]]; then
    shift
    cmd="$1"
  fi

  local session="${branch//\//-}"
  local worktree_root
  worktree_root="$(git rev-parse --show-toplevel 2>/dev/null)" \
    || { echo "Error: not inside a git repo."; return 1; }

  local repo_name parent worktree_path
  repo_name="$(basename "$worktree_root")"
  parent="$(dirname "$worktree_root")"
  worktree_path="${parent}/${repo_name}-${session}"

  if git worktree list | grep -q "$worktree_path"; then
    echo "Worktree already exists at $worktree_path"
  else
    git worktree add "$worktree_path" -b "$branch" "$base" 2>/dev/null \
      || git worktree add "$worktree_path" "$branch"
    echo "Created worktree at $worktree_path"
  fi

  if tmux has-session -t "$session" 2>/dev/null; then
    echo "Attaching to existing tmux session: $session"
    tmux attach-session -t "$session"
  else
    tmux new-session -s "$session" -c "$worktree_path" \
      "cd '$worktree_path' && $cmd; exec $SHELL"
  fi
}

worktree-tmux-rm() {
  if [[ $# -eq 0 ]]; then
    cat <<'EOF'
worktree-tmux-rm — Tear down a git worktree and its tmux session

USAGE
  worktree-tmux-rm <branch>

ARGUMENTS
  branch        The branch name used when creating the session.

EXAMPLES
  worktree-tmux-rm feature/my-task
  worktree-tmux-rm fix/bug-123

WHAT IT DOES
  1. Kills the tmux session for the branch
  2. Force-removes the git worktree (<parent>/<repo>-<branch>)
  3. Deletes the local branch (soft delete — warns if unmerged)

NOTE
  Run from anywhere inside the original repo.
  Use 'git branch -D <branch>' manually to force-delete an unmerged branch.
EOF
    return 0
  fi

  local branch="$1"
  local session="${branch//\//-}"
  local worktree_root
  worktree_root="$(git rev-parse --show-toplevel 2>/dev/null)" \
    || { echo "Error: not inside a git repo."; return 1; }

  local repo_name parent worktree_path
  repo_name="$(basename "$worktree_root")"
  parent="$(dirname "$worktree_root")"
  worktree_path="${parent}/${repo_name}-${session}"

  tmux kill-session -t "$session" 2>/dev/null && echo "Killed tmux session: $session"
  git worktree remove --force "$worktree_path" 2>/dev/null && echo "Removed worktree: $worktree_path"
  git branch -d "$branch" 2>/dev/null || echo "Branch '$branch' not deleted (unmerged or already gone — use 'git branch -D $branch' to force)"
}

cc-worktree() {
  if [[ $# -eq 0 ]]; then
    cat <<'EOF'
cc-worktree — Create a git worktree + tmux session and launch Claude Code

USAGE
  cc-worktree <branch> [base-branch]

ARGUMENTS
  branch        Branch to create or reuse.
  base-branch   Where to branch from. Defaults to HEAD.

EXAMPLES
  cc-worktree feature/my-task          # new branch off HEAD, launch claude
  cc-worktree fix/bug-123 main         # new branch off main, launch claude
  cc-worktree feature/my-task          # already exists → just attaches

NOTE
  Shorthand for: worktree-tmux <branch> [base] -c claude

SEE ALSO
  worktree-tmux <branch> [base] -c <cmd>    Run any command instead of claude
  cc-worktree-rm <branch>                   Tear down when done
  cwt <branch> [editor]                     Open the worktree in an editor
EOF
    return 0
  fi

  if [[ -n "$2" ]]; then
    worktree-tmux "$1" "$2" -c claude
  else
    worktree-tmux "$1" -c claude
  fi
}

cc-worktree-rm() {
  if [[ $# -eq 0 ]]; then
    cat <<'EOF'
cc-worktree-rm — Tear down a Claude Code worktree and its tmux session

USAGE
  cc-worktree-rm <branch>

NOTE
  Shorthand for: worktree-tmux-rm <branch>

SEE ALSO
  worktree-tmux-rm <branch>    Generic version
EOF
    return 0
  fi

  worktree-tmux-rm "$1"
}

cwt() {
  if [[ $# -eq 0 ]]; then
    cat <<'EOF'
cwt — Open an existing worktree in an editor

USAGE
  cwt <branch> [editor]

ARGUMENTS
  branch    Branch name of the worktree to open.
  editor    Editor to open the worktree in. Defaults to $EDITOR or nvim.

EXAMPLES
  cwt feature/my-task           # open in $EDITOR
  cwt feature/my-task nvim      # open in nvim
  cwt feature/my-task code      # open in VS Code

NOTE
  Worktrees are expected at <parent>/<repo>-<branch> (created by worktree-tmux).

SEE ALSO
  worktree-tmux <branch> [-c <cmd>]    Create a new worktree + tmux session
  cc-worktree <branch>                 Create worktree and launch claude
EOF
    return 0
  fi

  local branch="$1"
  local editor="${2:-${EDITOR:-nvim}}"
  local session="${branch//\//-}"
  local worktree_root
  worktree_root="$(git rev-parse --show-toplevel 2>/dev/null)" \
    || { echo "Error: not inside a git repo."; return 1; }

  local repo_name parent worktree_path
  repo_name="$(basename "$worktree_root")"
  parent="$(dirname "$worktree_root")"
  worktree_path="${parent}/${repo_name}-${session}"

  if [[ ! -d "$worktree_path" ]]; then
    echo "Worktree not found: $worktree_path"
    echo "Create it with: worktree-tmux $branch"
    return 1
  fi

  "$editor" "$worktree_path"
}

# development for your env below: CHECK BEFORE SAVING OUTSIDE LOCAL
# source ~/.YOURCOMPANY/secrets.rc
# source ~/.YOURCOMPANY/.zshrc
