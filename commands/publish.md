将当前项目首次发布到 GitHub。创建远程仓库、推送代码、在项目文档中记录发布信息。

全程自主执行，不要中途停下来问我（除非下面明确标注需要问的地方）。

## 前置：读取规范

1. 读 `~/Opensource/CLAUDE.md`（工作区统一规范，含首次发布记录要求）
2. 读 `~/Opensource/ai-dev-guide.md`（详细开发规范）

## 第一步：检查发布条件

1. 确认当前目录在 git 仓库中
2. 确认至少有一次 commit（`git log --oneline -1`）
3. 检查 `git remote -v`：
   - 如果已有 origin → 提示"已有远程仓库"，显示地址，询问是否继续推送
   - 如果没有 origin → 继续创建
4. 检查工作区是否干净（`git status --porcelain`）
   - 有未提交的改动 → 提示用户先提交，**不自动提交**
5. 确认 `.gitignore` 存在且合理（没有跟踪 node_modules、.env 等）
6. 确认没有敏感文件被跟踪（.env、密钥文件等）

## 第二步：确认发布信息

从用户指令或项目 CLAUDE.md 中提取：

| 信息 | 必填 | 默认值 |
|------|------|--------|
| 仓库名 | 否 | 当前目录名 |
| 可见性 | 否 | private |
| 描述 | 否 | CLAUDE.md 概述或 README 第一段 |

如果用户没有指定可见性，**默认 private**。只在用户明确说"公开"时才用 public。

## 第三步：创建 GitHub 仓库

```bash
gh repo create <仓库名> --<visibility> --description "<描述>" --source . --push
```

如果仓库名冲突，追加提示让用户改名。

## 第四步：更新 CLAUDE.md

在项目 `CLAUDE.md` 中添加 `## 首次发布记录` 小节（如果已有则更新）：

```markdown
## 首次发布记录

- **GitHub**: <仓库完整 URL>
- **可见性**: public / private
- **日期**: <今天日期>
- **默认分支**: main
- **本地路径**: <完整路径>
```

如果是 monorepo 或目录映射不是 1:1 的情况，额外记录：

```markdown
- **目录映射**:
  - 本地 `src/` → 仓库 `src/`
  - 本地 `docs/` → 仓库 `docs/`
```

## 第五步：更新工作区项目索引

读 `~/Opensource/CLAUDE.md`，在 `## 项目索引` 表格中：
- 如果项目已有条目 → 更新状态
- 如果没有 → 添加新行

## 第六步：提交发布记录

```bash
git add CLAUDE.md
git commit -m "docs: add publish record to CLAUDE.md"
git push
```

## 完成后

给一个简短总结：
- GitHub 仓库地址（可点击）
- 可见性
- 分支
- 下一步建议（如"设置 CI/CD"、"邀请协作者"等）
