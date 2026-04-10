同步上游仓库的最新代码到当前 fork。拉取上游更新、合并到本地分支、推送到 fork。

全程自主执行，不要中途停下来问我。

## 前置检查

1. 确认当前目录在 git 仓库中
2. 确认工作区干净（`git status --porcelain`）
   - 不干净 → 提示用户先提交或 stash，**不自动处理未提交的改动**
3. 检查 remote 列表（`git remote -v`）：
   - 有 `upstream` → 继续
   - 没有 `upstream` 但有 `origin` → 尝试通过 `gh` 查找上游：
     ```bash
     gh repo view --json parent --jq '.parent.owner.login + "/" + .parent.name'
     ```
     - 找到 → 自动添加 `git remote add upstream https://github.com/<owner>/<repo>.git`
     - 没找到 → 提示用户手动添加 upstream

## 第一步：获取上游更新

```bash
git fetch upstream
```

显示上游有多少新 commit（与本地 main 的差距）。

## 第二步：确定同步策略

**同步到 main 分支：**

```bash
# 切到 main
git checkout main

# 合并上游
git merge upstream/main
```

如果有冲突：
1. 列出冲突文件
2. 逐个解决冲突（保留上游改动为主，除非涉及本地定制部分）
3. 如果项目有 `FORK.md`，参考其中的定制点记录来判断冲突解决策略

```bash
# 推送到 fork
git push origin main
```

**如果用户有开发中的分支（用户指定或从 git branch 推断）：**

```bash
# 切到开发分支
git checkout <branch>

# rebase 到最新 main
git rebase main
```

如果 rebase 有冲突：
1. 列出冲突文件
2. 逐个解决
3. `git rebase --continue`

```bash
git push origin <branch> --force-with-lease
```

注意：使用 `--force-with-lease` 而非 `--force`，更安全。

## 第三步：检查同步结果

```bash
# 确认本地 main 与 upstream/main 一致
git log --oneline main..upstream/main  # 应为空

# 显示本地领先上游的 commit（如果有）
git log --oneline upstream/main..main
```

## 完成后

给一个简短总结：
- 同步了多少个 commit
- 是否有冲突及如何解决
- 开发分支是否已 rebase（如果有的话）
- 当前各分支状态
