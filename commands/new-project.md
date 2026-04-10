用户要创建一个新项目。你的任务是：完成全部脚手架工作，让项目从第一秒起就有清晰的 AI 协作上下文。

全程自主执行，不要中途停下来问我（除非下面明确标注需要问的地方）。

## 前置：探测工作区环境

依次检查以下位置，判断当前工作模式：

1. 从当前目录向上查找，是否有某个父目录包含工作区级 `CLAUDE.md`（含 `## 项目索引` 表格的）
2. 检查常见工作区根路径是否有 `CLAUDE.md`（如 `~/Opensource/CLAUDE.md`、`~/workspace/CLAUDE.md`、`~/projects/CLAUDE.md`、`~/dev/CLAUDE.md`）
3. 检查是否有配套的开发规范文件（如 `ai-dev-guide.md`）

**结果 A — 找到工作区**：
- 读取工作区 `CLAUDE.md`，了解目录约定和项目分类规则
- 如果有 `ai-dev-guide.md`，也读取
- 后续按工作区约定选择目录、更新项目索引

**结果 B — 没有工作区**：
- 在当前目录下创建项目（或用户指定的路径）
- 跳过项目索引更新等工作区操作
- 仍然创建完整的项目级文件（CLAUDE.md、AGENTS.md 等）

## 第一步：确认项目信息

从用户的指令中提取以下信息。**缺失的必填项一次问完**：

| 信息 | 必填 | 默认值 |
|------|------|--------|
| 项目名称 | ✅ | — |
| 一句话描述 | ✅ | — |
| 技术栈 | ✅ | — |
| 包管理器 | 否 | Node→pnpm, Python→uv, Rust→cargo, Go→go mod |
| 创建位置 | 否 | 见下方逻辑 |

**创建位置决策**：

如果在工作区模式（结果 A）：
- 读取工作区 CLAUDE.md 中的目录约定（通常按类型分 web/ai/cli/games 等）
- 根据技术栈和描述自动选择分类目录
- 用户已经在某个子目录下时，直接用当前目录

如果在独立模式（结果 B）：
- 在当前目录下创建以项目名命名的子目录
- 或者如果用户指定了路径，用指定路径

## 第二步：创建项目目录和初始化

```bash
mkdir -p <project-path>
cd <project-path>
git init
```

## 第三步：根据技术栈初始化项目

根据用户指定的技术栈执行对应的初始化命令。常见组合：

| 技术栈 | 初始化方式 |
|--------|-----------|
| Next.js + TypeScript | `pnpm create next-app . --typescript --tailwind --eslint --app --src-dir` |
| Vite + React + TS | `pnpm create vite . --template react-ts` 然后安装依赖 |
| Vite + Vue + TS | `pnpm create vite . --template vue-ts` 然后安装依赖 |
| Node.js CLI | `pnpm init` 然后配置 TypeScript |
| Python | `uv init` |
| Rust | `cargo init` |
| Go | `go mod init <module-name>` |
| 纯 HTML/CSS/JS | 创建 index.html、style.css、main.js |

如果上面没有覆盖，根据技术栈自行判断最佳初始化方式。

初始化完成后安装依赖，确保项目可运行。

**包管理器检测**：如果用户没有指定，优先用系统中已安装的工具。依次检查 `pnpm`、`npm`、`yarn`（Node.js 场景）。

## 第四步：创建 .mise.toml（如果 mise 可用）

先检查 `which mise`。如果 mise 已安装，根据技术栈创建版本锁定文件：

```toml
[tools]
node = "lts"       # Node.js 项目
# python = "3.12"  # Python 项目
# go = "latest"    # Go 项目
```

如果 mise 未安装，跳过此步。Rust 项目也跳过（由 rustup 管理）。

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

根据技术栈生成合适的 .gitignore。基础条目：

```
.env
.env.local
.DS_Store
*.log
```

按技术栈补充：
- Node.js: `node_modules/`, `dist/`, `.next/`, `.nuxt/`
- Python: `__pycache__/`, `.venv/`, `*.pyc`
- Rust: `target/`
- Go: 通常不需要额外条目

## 第八步：判断是否需要开发追踪

如果用户描述中包含明确的开发计划（多阶段、多功能、复杂需求），则：

1. 创建 `PLAN.md`：

```markdown
# <项目名> 开发计划

## 目标
<从用户描述提取>

## 阶段计划

### Phase 1: <名称>
- [ ] 任务 1
- [ ] 任务 2
```

2. 创建 `STATUS.md`：

```markdown
# <项目名> 开发状态

> 最后更新: <今天日期>

## 当前阶段
Phase 1: <名称>

## 进度
| 功能/改动 | 状态 | 备注 |
|-----------|------|------|

## 下一步
-
```

3. 在 CLAUDE.md 中添加 `## 活跃文档` 小节

如果只是简单项目或用户没有提计划，跳过此步。

## 第九步：首次提交

```bash
git add -A
git commit -m "init: scaffold project"
```

## 第十步：更新工作区索引（仅工作区模式）

如果前置探测找到了工作区 CLAUDE.md（结果 A），在其 `## 项目索引` 表格中添加新行。

如果是独立模式（结果 B），跳过此步。

## 完成后

给一个简短总结：
- 项目创建在哪里
- 技术栈是什么
- 怎么启动开发
- 下一步建议（如 `/dev-init` 初始化开发追踪、`/publish` 推送到 GitHub）
