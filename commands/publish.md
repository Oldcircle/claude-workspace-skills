将当前项目首次发布到 GitHub。创建远程仓库、推送代码、在项目文档中记录发布信息。

全程自主执行，不要中途停下来问我（除非下面明确标注需要问的地方）。

## 前置：探测环境

1. 确认 `gh` CLI 已安装且已登录（`gh auth status`）
   - 未安装 → 提示安装方法后终止
   - 未登录 → 提示运行 `gh auth login` 后终止
2. 检查是否有工作区级 CLAUDE.md（向上查找或检查常见路径）
   - 找到 → 后续更新工作区索引
   - 没找到 → 跳过工作区索引

## 第一步：检查发布条件

1. 确认当前目录在 git 仓库中
   - 不在 → 提示先运行 `git init`，终止
2. 确认至少有一次 commit
   - 没有 → 提示先提交代码，终止
3. 检查 `git remote -v`：
   - 已有 origin → 显示地址，询问是否要推送到已有仓库（而非新建）
   - 没有 origin → 继续创建
4. 检查工作区是否干净（`git status --porcelain`）
   - 有未提交的改动 → 列出变更文件，提示用户先提交，**不自动提交**
5. 快速安全检查：
   - 扫描 git 跟踪的文件，警告如果发现 `.env`、`*.key`、`*secret*`、`*credential*`
   - 仅警告，不阻断（用户可能有理由）

## 第二步：确认发布信息

从用户指令、项目 CLAUDE.md 或 README 中提取：

| 信息 | 默认值 |
|------|--------|
| 仓库名 | 当前目录名 |
| 可见性 | **private**（除非用户明确说"公开/public"） |
| 描述 | CLAUDE.md 概述 → README 第一段 → 留空 |

用户没有指定任何信息时用全部默认值，**不额外询问**。

## 第三步：创建 GitHub 仓库并推送

```bash
gh repo create <仓库名> --<visibility> --description "<描述>" --source . --push
```

如果仓库名冲突，提示用户改名。

## 第四步：更新项目 CLAUDE.md

如果项目有 `CLAUDE.md`，添加或更新 `## 首次发布记录` 小节：

```markdown
## 首次发布记录

- **GitHub**: <仓库完整 URL>
- **可见性**: public / private
- **日期**: <今天日期>
- **默认分支**: main
```

如果没有 `CLAUDE.md`，创建一个最小版本：

```markdown
# <项目名>

## 首次发布记录

- **GitHub**: <仓库完整 URL>
- **可见性**: public / private
- **日期**: <今天日期>
- **默认分支**: main
```

## 第五步：更新工作区索引（仅工作区模式）

如果前置探测找到了工作区 CLAUDE.md：
- 项目已有条目 → 更新状态，添加 GitHub 地址
- 没有条目 → 添加新行

没有工作区则跳过。

## 第六步：提交发布记录并推送

```bash
git add CLAUDE.md
git commit -m "docs: add publish record"
git push
```

如果创建了 AGENTS.md（因为之前没有），一并提交。

## 完成后

给一个简短总结：
- GitHub 仓库地址（可点击）
- 可见性
- 下一步建议
