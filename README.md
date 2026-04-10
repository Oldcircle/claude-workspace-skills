# Claude Workspace Skills

> **Start every project right. Check it anytime. Ship it in seconds.**

A collection of [Claude Code](https://claude.ai/claude-code) slash commands that automate workspace conventions — so you can open a fresh session without losing context, and every project stays consistent from day one.

## Why

When you use AI-assisted development across many projects, the biggest win isn't code generation — it's **zero-cost context switching**. That requires every project to follow the same structure, the same documentation pattern, the same conventions.

These skills encode those conventions into executable commands. No more forgetting to create `AGENTS.md` symlinks. No more inconsistent `CLAUDE.md` files. No more "wait, did I push this?"

## Skills

| Command | What it does |
|---------|-------------|
| `/new-project` | Full project scaffolding — picks the right directory, inits git, creates `CLAUDE.md` from template, sets up runtime version locking, first commit |
| `/health-check` | Audits current project against workspace conventions — checks for missing files, broken symlinks, stale docs, untracked secrets |
| `/publish` | First-time GitHub publish — creates repo, pushes, records publish info in `CLAUDE.md` |
| `/sync-fork` | Syncs upstream changes into your fork — auto-detects upstream, merges, rebases dev branches |

## The Full Workflow

These skills complement the existing `/onboard` and `/dev-init` commands:

```
/onboard        Clone & run any project, document everything
                    ↓
/dev-init        Add PLAN.md + STATUS.md for multi-session tracking
                    ↓
/new-project     Create a project from scratch (instead of onboard)
                    ↓
/health-check    Verify conventions at any time
                    ↓
/publish         Push to GitHub with proper records
                    ↓
/sync-fork       Keep forks up to date
```

## Install

```bash
git clone https://github.com/<you>/claude-workspace-skills.git ~/Opensource/projects/cli/claude-workspace-skills
cd ~/Opensource/projects/cli/claude-workspace-skills
chmod +x install.sh && ./install.sh
```

The install script creates **symlinks** from `commands/` into `~/.claude/commands/`. Edit the source files and changes take effect immediately — no reinstall needed.

## Uninstall

```bash
./install.sh --uninstall
```

## What Gets Checked by `/health-check`

| Category | Checks |
|----------|--------|
| **Instruction files** | `CLAUDE.md` exists with required sections, `AGENTS.md` is a valid symlink |
| **Version management** | `.mise.toml` exists and versions match runtime |
| **Git hygiene** | `.gitignore` present, no large files tracked, no secrets committed |
| **Active documents** | Listed docs actually exist, `STATUS.md` freshness |
| **First-run record** | Documented in `CLAUDE.md` for vendor/fork projects |
| **Workspace index** | Project registered in workspace `CLAUDE.md` |

## What `/new-project` Sets Up

```
my-project/
├── CLAUDE.md            # Filled with real project info, not blanks
├── AGENTS.md            # → CLAUDE.md (symlink)
├── .mise.toml           # Runtime version locked
├── .gitignore           # Tech-stack appropriate
├── PLAN.md              # If project has a development plan
├── STATUS.md            # If project has a development plan
└── (framework files)    # From create-next-app / vite / cargo init / etc.
```

## Requirements

- [Claude Code](https://claude.ai/claude-code) (CLI or IDE extension)
- [GitHub CLI](https://cli.github.com/) (`gh`) — for `/publish` and `/sync-fork`
- [mise](https://mise.jdx.dev/) — for runtime version management

## Conventions Reference

These skills enforce the conventions defined in:

- [`ai-dev-guide.md`](https://github.com/user/dotfiles) — Full development workflow guide
- Workspace `CLAUDE.md` — Directory structure, project index, documentation rules

Key principles:
- **`CLAUDE.md` is the single source of truth** for every project
- **`AGENTS.md` is always a symlink** to `CLAUDE.md`
- **Active documents checklist** in `CLAUDE.md` tells AI what to read
- **`STATUS.md` is a session handoff doc**, not a changelog
- **First-run and first-publish records** go in `CLAUDE.md`

## License

MIT
