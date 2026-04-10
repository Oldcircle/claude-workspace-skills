用户要创建一个新项目。你的任务是：按照工作区约定完成全部脚手架工作，让项目从第一秒起就符合规范。

全程自主执行，不要中途停下来问我（除非下面明确标注需要问的地方）。

## 前置：读取规范

1. 读 `~/Opensource/CLAUDE.md`（工作区统一规范）
2. 读 `~/Opensource/ai-dev-guide.md`（详细开发规范 + 项目模板）

后续所有操作遵守这些规范。

## 第一步：确认项目信息

从用户的指令中提取以下信息。**缺失的项必须问用户，一次问完**：

| 信息 | 必填 | 默认值 |
|------|------|--------|
| 项目名称 | ✅ | — |
| 项目类型 | ✅ | — |
| 一句话描述 | ✅ | — |
| 技术栈 | ✅ | — |
| 包管理器 | 否 | Node→pnpm, Python→uv, Rust→cargo |
| 可见性 | 否 | private |

**项目类型决定目录**：

| 类型关键词 | 目录 |
|-----------|------|
| web / 前端 / 后端 / 全栈 | `~/Opensource/projects/web/` |
| ai / ml / llm | `~/Opensource/projects/ai/` |
| cli / 命令行 / 工具 | `~/Opensource/projects/cli/` |
| mobile / 移动端 | `~/Opensource/projects/mobile/` |
| game / 游戏 | `~/Opensource/projects/games/` |
| 实验 / 临时 / playground | `~/Opensource/projects/playground/` |

如果用户已经在某个 `projects/` 子目录下，直接用当前目录作为父目录。

## 第二步：创建项目目录和初始化

```bash
mkdir -p ~/Opensource/projects/<type>/<project-name>
cd ~/Opensource/projects/<type>/<project-name>
git init
```

## 第三步：根据技术栈初始化项目

根据用户指定的技术栈执行对应的初始化命令。常见组合：

| 技术栈 | 初始化方式 |
|--------|-----------|
| Next.js + TypeScript | `pnpm create next-app . --typescript --tailwind --eslint --app --src-dir` |
| Vite + React + TS | `pnpm create vite . --template react-ts` 然后 `pnpm install` |
| Vite + Vue + TS | `pnpm create vite . --template vue-ts` 然后 `pnpm install` |
| Node.js CLI | `pnpm init` 然后配置 TypeScript |
| Python | `uv init` |
| Rust | `cargo init` |
| 纯 HTML/CSS/JS | 创建 index.html、style.css、main.js |

如果上面没有覆盖，根据技术栈自行判断最佳初始化方式。

初始化完成后立即安装依赖，确保项目可运行。

## 第四步：创建 .mise.toml

根据技术栈创建版本锁定文件：

```toml
[tools]
node = "lts"       # Node.js 项目
# python = "3.12"  # Python 项目
# go = "latest"    # Go 项目
```

Rust 不需要（由 rustup 管理）。

## 第五步：创建 CLAUDE.md

按以下模板创建，**用实际项目信息填充**，不留占位符：

```markdown
# <项目名称>

## 概述
<一句话描述>

## 技术栈
- 语言: xxx
- 框架: xxx
- 包管理器: xxx

## 项目结构
<根据实际初始化结果填写关键目录>

## 开发命令
- 安装依赖: `xxx`
- 启动开发: `xxx`
- 运行测试: `xxx`
- 构建: `xxx`

## 约定
- 提交信息格式: conventional commits
- 分支策略: main + feat/fix/refactor 分支

## 首次运行记录
- **日期**: <今天日期>
- **状态**: 成功
- **踩坑点**: 无
```

## 第六步：创建 AGENTS.md 软链接

```bash
ln -sf CLAUDE.md AGENTS.md
```

## 第七步：创建 .gitignore

根据技术栈生成合适的 .gitignore。必须包含：

```
node_modules/
dist/
.env
.env.local
.DS_Store
*.log
```

根据具体技术栈补充其他条目（Python: `__pycache__/`, `.venv/`；Rust: `target/` 等）。

## 第八步：判断是否需要开发追踪

如果用户描述中包含明确的开发计划（多阶段、多功能），则：
1. 创建 `PLAN.md` 和 `STATUS.md`（格式同 `/dev-init`）
2. 在 CLAUDE.md 中添加 `## 活跃文档` 小节

如果只是简单项目或用户没有提计划，跳过此步。用户之后可以随时运行 `/dev-init`。

## 第九步：首次提交

```bash
git add -A
git commit -m "init: scaffold project with workspace conventions"
```

## 第十步：更新工作区项目索引

读 `~/Opensource/CLAUDE.md`，在 `## 项目索引` 表格中添加新行：

```markdown
| <项目名> | `<完整路径>` | 已创建 |
```

## 完成后

给一个简短总结：
- 项目创建在哪里
- 技术栈是什么
- 怎么启动开发
- 下一步建议（如"运行 `/dev-init` 初始化开发追踪"或"运行 `/publish` 推送到 GitHub"）
