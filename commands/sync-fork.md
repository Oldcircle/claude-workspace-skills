同步上游仓库的最新代码到当前 fork。拉取上游更新、合并到本地分支、推送到 fork。

全程自主执行，不要中途停下来问我。

## 前置检查

1. 确认当前目录在 git 仓库中
   - 不在 → 提示"当前目录不是 git 仓库"，终止
2. 检查工作区是否干净（`git status --porcelain`）
   - 不干净 → 列出变更文件，提示用户先提交或 stash，**不自动处理**
3. 检查 remote 列表（`git remote -v`）

### upstream 自动检测

**情况 1 — 已有 upstream**：直接继续

**情况 2 — 没有 upstream 但有 origin**：
- 检查 `gh` 是否可用（`which gh`）
- 如果可用，尝试自动查找上游：
  ```bash
  gh repo view --json parent --jq '.parent.owner.login + "/" + .parent.name'
  ```
  - 找到 → 自动添加 `git remote add upstream https://github.com/<owner>/<repo>.git`
  - 没找到（不是 fork）→ 提示"这个仓库不是 fork，无法自动检测上游"，让用户手动提供

- 如果 `gh` 不可用：提示用户手动添加
  ```
  git remote add upstream https://github.com/<original-owner>/<repo>.git
  ```

**情况 3 — 都没有**：提示"没有任何 remote 配置"，终止

## 第一步：获取上游更新

```bash
git fetch upstream
```

检测上游的默认分支名（`upstream/main` 或 `upstream/master`）：
```bash
git remote show upstream | grep 'HEAD branch'
```

显示与本地的差距：
```bash
git log --oneline HEAD..upstream/<default-branch> | wc -l
```

如果没有新 commit → 提示"已是最新，无需同步"，结束。

## 第二步：同步默认分支

```bash
# 确保在默认分支上
git checkout <local-default-branch>

# 合并上游
git merge upstream/<default-branch>
```

**如果有冲突**：
1. 列出冲突文件
2. 检查项目是否有 `FORK.md`（记录定制点），参考它来判断冲突解决策略
3. 逐个解决冲突：
   - 纯上游改动的文件 → 接受上游
   - 涉及本地定制的文件 → 保留定制，合并上游的非冲突部分
   - 无法自动判断 → 列出冲突让用户选择
4. `git add <resolved-files> && git commit`

```bash
# 推送到 fork
git push origin <local-default-branch>
```

## 第三步：rebase 开发分支（可选）

检查是否有活跃的开发分支：

1. 如果用户在指令中指定了分支名 → 直接 rebase 该分支
2. 如果没有指定，检查 `git branch` 列表：
   - 有 `feat/*`、`fix/*`、`refactor/*` 等开发分支 → 询问用户是否要 rebase
   - 没有 → 跳过

```bash
git checkout <dev-branch>
git rebase <local-default-branch>
```

如果 rebase 有冲突，逐个解决，然后 `git rebase --continue`。

```bash
git push origin <dev-branch> --force-with-lease
```

注意：使用 `--force-with-lease` 而非 `--force`。

## 第四步：验证同步结果

```bash
# 确认本地默认分支与上游一致
git log --oneline <local-default-branch>..upstream/<default-branch>
# 应为空

# 显示本地领先上游的 commit（如果有定制）
git log --oneline upstream/<default-branch>..<local-default-branch>
```

## 完成后

给一个简短总结：
- 同步了多少个 commit
- 是否有冲突及如何解决
- 开发分支状态（如有）
