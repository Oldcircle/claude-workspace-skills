# Claude Workspace Skills

## 概述

Claude Code 自定义 slash command 集合，将 `~/Opensource` 工作区的开发约定自动化为可执行的 skill。

## 技术栈

- 格式: Markdown（Claude Code commands 格式）
- 安装: Shell 脚本（符号链接部署）
- 依赖: Claude Code CLI、gh CLI、mise

## 项目结构

```
claude-workspace-skills/
├── CLAUDE.md          # 本文件
├── AGENTS.md          # → CLAUDE.md
├── README.md          # 项目说明
├── install.sh         # 部署脚本（符号链接到 ~/.claude/commands/）
└── commands/          # skill 定义
    ├── new-project.md   # /new-project — 新项目脚手架
    ├── health-check.md  # /health-check — 项目规范合规检查
    ├── publish.md       # /publish — 首次发布到 GitHub
    └── sync-fork.md     # /sync-fork — 同步上游到 fork
```

## 开发命令

- 安装/更新部署: `./install.sh`
- 卸载: `./install.sh --uninstall`

## 与现有 skill 的关系

| 已有 skill | 位置 | 本项目不重复 |
|------------|------|-------------|
| `/dev-init` | `~/.claude/commands/dev-init.md` | 初始化 PLAN.md + STATUS.md |
| `/onboard` | `~/.claude/commands/onboard.md` | 项目接手与首次运行 |

本项目的 skill 与它们互补：
- `/onboard` → `/dev-init` → `/new-project`（创建） / `/health-check`（检查） / `/publish`（发布）

## 首次发布记录

- **GitHub**: https://github.com/Oldcircle/claude-workspace-skills
- **可见性**: public
- **日期**: 2026-04-10
- **默认分支**: main
- **本地路径**: `/Users/yb/Opensource/projects/cli/claude-workspace-skills`

## 约定

- 每个 command 文件是纯 Markdown，无 YAML frontmatter（与现有 dev-init/onboard 一致）
- 所有 skill 遵循 `~/Opensource/ai-dev-guide.md` 中的约定
- skill 内容使用中文（与用户偏好一致）
- 安装方式为符号链接，修改源文件即时生效
