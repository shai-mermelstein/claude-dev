# claude-dev

A personal template repo for starting new projects with [Claude Code](https://claude.com/claude-code) preconfigured in a dev container.

Click **"Use this template"** on GitHub to start a new repo from this one, then adjust `.devcontainer/devcontainer.json` for the project's actual language/tools.

## What's included

- **`.devcontainer/`** — a minimal Ubuntu-based dev container that installs the Claude Code CLI on creation (`postCreate.sh`), plus the Code Spell Checker extension.
- **`.claude/settings.json`** — points Claude Code at the custom status line.
- **`.claude/statusline.sh`** — a status line mirroring the devcontainers bash prompt (user, cwd, git branch/dirty state), plus context-window usage.
- **`.gitignore`** — ignores Claude Code's local/generated files (`.claude/worktrees/`, `.claude/settings.local.json`, `CLAUDE.local.md`).

## Adapting per project

Swap the `image` in `.devcontainer/devcontainer.json` for the language you need (e.g. a Node, Python, or C++ devcontainer base image), and add any extensions/tools that project needs.
