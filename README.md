# Claude Workspace Skills

> **Start every project right. Check it anytime. Ship it in seconds.**

A set of [Claude Code](https://claude.ai/claude-code) slash commands that give your AI assistant **project memory** — consistent documentation, convention checks, and workflow automation that survive across sessions.

## The Problem

You start a new Claude Code session. The AI doesn't know your project structure, your conventions, or what you were working on yesterday. You explain everything again. Every. Single. Time.

**These skills fix that.** They create and maintain the context files that let any new session pick up exactly where the last one left off.

## Skills

| Command | What it does |
|---------|-------------|
| **`/new-project`** | Full project scaffolding — creates directory, initializes framework, generates `CLAUDE.md` with real project info, sets up version locking, first commit |
| **`/health-check`** | Audits your project against AI collaboration best practices — checks for missing context files, stale docs, tracked secrets, broken symlinks |
| **`/publish`** | First-time GitHub publish — creates repo (private by default), pushes, records publish info in project docs |
| **`/sync-fork`** | Syncs upstream changes into your fork — auto-detects upstream, merges, rebases dev branches |

## Works With or Without a Workspace

These skills **auto-detect your environment**:

| Environment | What happens |
|-------------|-------------|
| **Full workspace** (global `CLAUDE.md` with project index, directory conventions) | Skills use your conventions — right directories, index updates, full checks |
| **Single project** (just a repo, no workspace structure) | Skills work at project level — creates `CLAUDE.md`, checks basics, skips workspace features |
| **Somewhere in between** | Skills adapt — use what's available, skip what's not |

No workspace setup required. No directories created that you didn't ask for. No config files dumped into your home directory.

## Install

```bash
# Clone the repo
git clone https://github.com/Oldcircle/claude-workspace-skills.git
cd claude-workspace-skills

# Run the installer (creates symlinks to ~/.claude/commands/)
chmod +x install.sh && ./install.sh
```

The install script creates **symlinks**, not copies. Edit the source files and changes take effect immediately.

```bash
# Uninstall
./install.sh --uninstall
```

## Quick Start

### Just created a new project?
```
/new-project
```
Tell it your project name, tech stack, and description. It handles everything else — directory, git init, framework setup, `CLAUDE.md`, `.gitignore`, version locking.

### Want to check if your project is set up well?
```
/health-check
```
Gets you a report like:
```
✅ CLAUDE.md exists with overview, tech stack, dev commands
✅ AGENTS.md is a valid symlink
❌ .gitignore missing node_modules/
⚠️ STATUS.md last updated 18 days ago
ℹ️ mise not installed, skipping version check
```
Offers to auto-fix what it can.

### Ready to push to GitHub?
```
/publish
```
Creates a private repo, pushes, and records the GitHub URL in your `CLAUDE.md`. Done.

### Working on a fork?
```
/sync-fork
```
Auto-detects the upstream repo, fetches changes, merges into your default branch, and optionally rebases your dev branches.

## What is `CLAUDE.md`?

`CLAUDE.md` is a file at the root of your project that tells Claude Code about your project — tech stack, how to run it, conventions, current status. Claude reads it automatically at the start of every session.

Think of it as a **README for your AI assistant**. These skills create and maintain it so you don't have to.

Paired with `AGENTS.md` (a symlink to `CLAUDE.md`), it ensures every AI tool that enters your project gets the same context.

## Plays Well With Others

These skills complement the existing `/onboard` and `/dev-init` commands:

```
Start from scratch     →  /new-project
Take over a project    →  /onboard
Track multi-session    →  /dev-init
  development progress
Check conventions      →  /health-check
Push to GitHub         →  /publish
Sync a fork            →  /sync-fork
```

## What Gets Checked

`/health-check` adapts its checks to what's available in your environment:

| Category | Checks |
|----------|--------|
| **AI context files** | `CLAUDE.md` exists with real content, `AGENTS.md` present |
| **Version management** | `.mise.toml` exists (only if mise is installed) |
| **Git hygiene** | `.gitignore` present, no secrets tracked, no huge files |
| **Dev tracking** | `STATUS.md` freshness, `PLAN.md` has structure (only if they exist) |
| **Publish record** | GitHub URL documented (only if remote exists) |
| **Workspace index** | Project listed in workspace index (only if workspace detected) |

## Requirements

- [Claude Code](https://claude.ai/claude-code) — the CLI, desktop app, or IDE extension
- [GitHub CLI](https://cli.github.com/) (`gh`) — needed for `/publish` and `/sync-fork`
- [mise](https://mise.jdx.dev/) — optional, for runtime version management

## License

MIT
