# Claude Workspace Skills

## 概述

Claude Code 自定义 slash command 集合，自动化 AI 协作的项目约定。支持完整工作区和单项目两种模式。

## 技术栈

- 格式: Markdown（Claude Code commands 格式）
- 安装: Shell 脚本（符号链接部署到 `~/.claude/commands/`）
- 依赖: Claude Code CLI（必须）、gh CLI（publish/sync-fork 需要）、mise（可选）

## 项目结构

```
claude-workspace-skills/
├── CLAUDE.md          # 本文件（项目指令）
├── AGENTS.md          # → CLAUDE.md（软链接）
├── README.md          # 项目说明（面向用户）
├── LICENSE            # MIT
├── install.sh         # 部署脚本
└── commands/          # skill 定义
    ├── new-project.md   # /new-project — 新项目脚手架
    ├── health-check.md  # /health-check — 项目规范合规检查
    ├── publish.md       # /publish — 首次发布到 GitHub
    └── sync-fork.md     # /sync-fork — 同步上游到 fork
```

## 开发命令

- 安装: `chmod +x install.sh && ./install.sh`
- 卸载: `./install.sh --uninstall`
- 测试: 在任意项目中运行 `/health-check` 验证

## 设计原则

- **环境自适应**: 每个 skill 开头有探测逻辑，自动判断工作区模式 vs 独立项目模式
- **不侵入**: 不创建用户未要求的目录或文件
- **工具可选**: mise 未安装则跳过版本检查，gh 未安装则提示安装
- **安全默认**: `/publish` 默认 private，不自动提交未提交的改动

## 首次发布记录

- **GitHub**: https://github.com/Oldcircle/claude-workspace-skills
- **可见性**: public
- **日期**: 2026-04-10
- **默认分支**: main

## 约定

- 每个 command 文件是纯 Markdown，无 YAML frontmatter
- skill 内容使用中文
- 安装方式为符号链接，修改源文件即时生效
