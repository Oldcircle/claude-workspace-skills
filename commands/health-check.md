检查当前项目是否符合 AI 协作的最佳实践。输出一份合规报告，列出通过项和需要修复的问题。

全程自主执行，不要中途停下来问我。

## 前置：探测环境

**判断检查范围**：

1. 从当前目录向上查找，是否有包含 `## 项目索引` 的工作区级 `CLAUDE.md`
2. 检查常见工作区路径（`~/Opensource/CLAUDE.md`、`~/workspace/CLAUDE.md`、`~/projects/CLAUDE.md`、`~/dev/CLAUDE.md`）
3. 如果有配套的 `ai-dev-guide.md`，读取了解完整规范

**结果 A — 找到工作区**：执行全部检查（项目级 + 工作区级）
**结果 B — 没有工作区**：仅执行项目级检查，跳过工作区索引等

## 检查项

按以下清单逐项检查，每项标记 ✅（通过）、⚠️（警告）、❌（不通过）。

**根据环境自动调整检查范围** — 没有的功能不扣分，只检查当前环境该有的。

---

### 1. AI 上下文文件（核心 — 所有项目必查）

- [ ] `CLAUDE.md` 存在
- [ ] `CLAUDE.md` 非空且包含有意义的内容（不只是模板占位符）
- [ ] `CLAUDE.md` 包含基本章节：概述、技术栈、开发命令（至少其中两项）
- [ ] `AGENTS.md` 存在
  - 最佳：是指向 `CLAUDE.md` 的软链接
  - 可接受：独立文件（某些框架/工具自带 AGENTS.md）
  - 不通过：不存在

### 2. 版本管理（检查 mise 是否可用）

先运行 `which mise` 判断：

**mise 已安装**：
- [ ] `.mise.toml` 或 `.tool-versions` 存在（Rust 纯项目例外）
- [ ] 锁定的版本与 `mise current` 实际使用的版本一致

**mise 未安装**：
- ℹ️ 跳过版本锁定检查（提示：推荐使用 mise 管理运行时版本）

### 3. Git 规范

- [ ] 项目在 git 仓库中（`git rev-parse --git-dir` 成功）
- [ ] `.gitignore` 存在
- [ ] `.gitignore` 包含基本条目（根据检测到的技术栈判断）：
  - Node.js 项目：`node_modules/`
  - Python 项目：`__pycache__/` 或 `.venv/`
  - Rust 项目：`target/`
  - 通用：`.env`、`.DS_Store`
- [ ] 没有明显的敏感文件被 git 跟踪（`.env`、`*.key`、`*credentials*`、`*secret*`）
- [ ] 没有超大文件（>10MB）被 git 跟踪

### 4. 活跃文档（如果存在 PLAN.md 或 STATUS.md）

这组检查仅在项目有开发追踪文件时执行：

- [ ] 如有 `PLAN.md`：包含目标和阶段/任务信息
- [ ] 如有 `STATUS.md`：包含最后更新日期
- [ ] 如有 `STATUS.md`：最后更新日期不超过 14 天（⚠️ 警告级别）
- [ ] `CLAUDE.md` 中有活跃文档清单，且列出的文件实际存在

### 5. 首次运行 / 发布记录（⚠️ 警告级别）

- [ ] `CLAUDE.md` 中有启动方式记录（"开发命令"或"首次运行记录"）
- [ ] 如果有 git remote：`CLAUDE.md` 中记录了 GitHub/远程仓库地址

### 6. 工作区索引（仅工作区模式）

**仅在结果 A（找到工作区）时检查**：
- [ ] 项目出现在工作区 CLAUDE.md 的项目索引表格中
- [ ] 索引中的路径与实际路径一致

---

## 技术栈自动检测

根据以下文件判断技术栈，调整检查内容：

| 文件 | 技术栈 |
|------|--------|
| `package.json` | Node.js |
| `Cargo.toml` | Rust |
| `pyproject.toml` / `requirements.txt` / `setup.py` | Python |
| `go.mod` | Go |
| `pom.xml` / `build.gradle` | Java |
| `mix.exs` | Elixir |
| `Gemfile` | Ruby |

## 输出格式

```
# 项目规范检查报告: <项目名>

📍 路径: <路径>
🔍 模式: 工作区模式 / 独立项目模式
📅 检查时间: <日期>

## 结果汇总

✅ 通过: X 项
⚠️ 警告: X 项
❌ 不通过: X 项
ℹ️ 跳过: X 项

## 详细结果

### AI 上下文文件
✅ CLAUDE.md 存在，包含概述、技术栈、开发命令
❌ AGENTS.md 不存在
   → 修复: ln -sf CLAUDE.md AGENTS.md

### 版本管理
ℹ️ mise 未安装，跳过版本锁定检查

...

## 建议操作

1. 运行 `ln -sf CLAUDE.md AGENTS.md` 创建软链接
2. ...
```

## 自动修复

报告输出后，**询问用户是否要自动修复**。

可自动修复：
- 创建 `AGENTS.md` 软链接（`ln -sf CLAUDE.md AGENTS.md`）
- 创建缺失的 `.gitignore`（合理默认值）
- 在 `CLAUDE.md` 中补充缺失的章节骨架
- 在工作区索引中添加项目（仅工作区模式）

不能自动修复（仅提示）：
- `CLAUDE.md` 不存在（需要用户提供项目信息，建议运行 `/onboard`）
- `STATUS.md` 过期（需要用户更新实际进度）
- 敏感文件/大文件被 git 跟踪（需要用户确认处理方式）
