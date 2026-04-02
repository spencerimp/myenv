#!/bin/bash
input=$(cat)

user=$(whoami)
host=$(hostname -s)
dir=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // empty')
[ -z "$dir" ] && dir=$(pwd)

# Shorten home directory to ~
home="$HOME"
short_dir="${dir/#$home/~}"

# Git branch (skip optional locks)
git_branch=""
if git -C "$dir" rev-parse --git-dir > /dev/null 2>&1; then
  git_branch=$(git -C "$dir" -c core.fsmonitor=false symbolic-ref --short HEAD 2>/dev/null || git -C "$dir" -c core.fsmonitor=false rev-parse --short HEAD 2>/dev/null)
  [ -n "$git_branch" ] && git_branch=" ($git_branch)"
fi

model=$(echo "$input" | jq -r '.model.display_name // empty')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
ctx_size=$(echo "$input" | jq -r '.context_window.context_window_size // empty')

ctx_info=""
if [ -n "$used" ] && [ -n "$ctx_size" ]; then
  # Format token counts as e.g. 12k/200k
  fmt_tokens() {
    local n=$1
    if [ "$n" -ge 1000 ]; then
      printf "%.0fk" "$(echo "scale=0; $n / 1000" | bc)"
    else
      printf "%d" "$n"
    fi
  }
  # Derive used tokens from percentage × size — avoids the input_tokens bug
  # where prompt caching makes input_tokens=1 while cache_read_input_tokens
  # holds the bulk of the context.
  used_tokens=$(echo "scale=0; $ctx_size * $used / 100" | bc)
  used_fmt=$(fmt_tokens "$used_tokens")
  total_fmt=$(fmt_tokens "$ctx_size")
  ctx_info=" ctx:${used_fmt}/${total_fmt} ($(printf '%.0f' "$used")%)"
elif [ -n "$used" ]; then
  ctx_info=" ctx:$(printf '%.0f' "$used")%"
fi

rate_info=""
five_pct=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
week_pct=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
if [ -n "$five_pct" ] || [ -n "$week_pct" ]; then
  rate_parts=""
  [ -n "$five_pct" ] && rate_parts="5h:$(printf '%.0f' "$five_pct")%"
  if [ -n "$week_pct" ]; then
    [ -n "$rate_parts" ] && rate_parts="$rate_parts "
    rate_parts="${rate_parts}7d:$(printf '%.0f' "$week_pct")%"
  fi
  rate_info=" $rate_parts"
fi

model_info=""
[ -n "$model" ] && model_info=" [$model]"

# PR link for current branch (cached)
# Cache lives in /tmp per repo+branch. PR numbers never change once set,
# so hits are cached indefinitely. Misses (no PR yet) expire after 60s.
pr_info=""
if [ -n "$git_branch" ] && command -v gh > /dev/null 2>&1; then
  branch_slug=$(echo "$git_branch" | tr '/' '-' | tr -cd '[:alnum:]-_')
  repo_slug=$(git -C "$dir" remote get-url origin 2>/dev/null | sed 's|.*[:/]\([^/]*/[^/]*\)\.git|\1|; s|.*[:/]\([^/]*/[^/]*\)$|\1|' | tr '/' '-')
  cache_file="/tmp/claude-statusline-pr-${repo_slug}-${branch_slug}.cache"

  pr_number=""
  if [ -f "$cache_file" ]; then
    cached=$(cat "$cache_file")
    if [ -n "$cached" ]; then
      # Has a PR number — cache indefinitely
      pr_number="$cached"
    else
      # Cached miss — re-check after 60s
      cache_age=$(( $(date +%s) - $(stat -c %Y "$cache_file" 2>/dev/null || echo 0) ))
      [ "$cache_age" -gt 60 ] && rm -f "$cache_file"
    fi
  fi

  if [ -z "$pr_number" ] && [ ! -f "$cache_file" ]; then
    pr_number=$(gh pr view --json number -q '.number' 2>/dev/null)
    echo -n "${pr_number}" > "$cache_file"
  fi

  if [ -n "$pr_number" ]; then
    pr_info=" PR #${pr_number}"
  fi
fi

printf "\033[32m%s@%s\033[0m:\033[34m%s\033[0m\033[33m%s\033[0m\033[36m%s\033[0m\033[35m%s\033[0m%s%s" \
  "$user" "$host" "$short_dir" "$git_branch" "$ctx_info" "$rate_info" "$model_info" "$pr_info"
