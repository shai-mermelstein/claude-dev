#!/bin/bash
# Mirrors the bash prompt from ~/.bashrc (devcontainers theme), plus context usage.
input=$(cat)

dir=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // empty')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

green=$'\033[0;32m'; lightblue=$'\033[1;34m'; cyan=$'\033[0;36m'
red=$'\033[1;31m'; yellow=$'\033[1;33m'; reset=$'\033[0m'

# user part: @GITHUB_USER or user name, then arrow
user="${GITHUB_USER:+@$GITHUB_USER}"
user="${user:-$(whoami)}"
out="${green}${user} ${reset}➜ "

# \w with PROMPT_DIRTRIM=4
wd="${dir/#$HOME/\~}"
IFS=/ read -ra parts <<< "$wd"
if [ "${#parts[@]}" -gt 4 ]; then
  wd=".../$(IFS=/; echo "${parts[*]: -4}")"
fi
out="${out}${lightblue}${wd} "

# git branch, same rules as the prompt
g() { git -C "${dir:-.}" --no-optional-locks "$@"; }
if [ "$(g config --get devcontainers-theme.hide-status 2>/dev/null)" != 1 ] \
  && [ "$(g config --get codespaces-theme.hide-status 2>/dev/null)" != 1 ]; then
  branch=$(g symbolic-ref --short HEAD 2>/dev/null || g rev-parse --short HEAD 2>/dev/null)
  if [ -n "$branch" ]; then
    out="${out}${cyan}(${red}${branch}"
    if [ "$(g config --get devcontainers-theme.show-dirty 2>/dev/null)" = 1 ] \
      && g ls-files --error-unmatch -m --directory --no-empty-directory -o --exclude-standard ":/*" >/dev/null 2>&1; then
      out="${out} ${yellow}✗"
    fi
    out="${out}${cyan}) "
  fi
fi

out="${out}${reset}[Ctx: $(printf '%.0f' "${used:-0}")%]"
printf '%s' "$out"
