#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
COMMANDS_SRC="$SCRIPT_DIR/commands"
COMMANDS_DST="$HOME/.claude/commands"

SKILLS=(new-project health-check publish sync-fork)

# --- Uninstall ---
if [[ "${1:-}" == "--uninstall" ]]; then
  echo "卸载 workspace skills..."
  for skill in "${SKILLS[@]}"; do
    target="$COMMANDS_DST/$skill.md"
    if [[ -L "$target" ]]; then
      rm "$target"
      echo "  ✓ 移除 $skill"
    else
      echo "  - $skill 不存在或非符号链接，跳过"
    fi
  done
  echo "卸载完成。"
  exit 0
fi

# --- Install ---
echo "安装 workspace skills..."
mkdir -p "$COMMANDS_DST"

for skill in "${SKILLS[@]}"; do
  src="$COMMANDS_SRC/$skill.md"
  dst="$COMMANDS_DST/$skill.md"

  if [[ ! -f "$src" ]]; then
    echo "  ✗ $skill.md 不存在，跳过"
    continue
  fi

  # 如果目标已存在且不是符号链接，备份
  if [[ -f "$dst" && ! -L "$dst" ]]; then
    mv "$dst" "$dst.bak"
    echo "  ⚠ 已备份原有 $skill.md → $skill.md.bak"
  fi

  ln -sf "$src" "$dst"
  echo "  ✓ $skill → $dst"
done

echo ""
echo "安装完成。可用命令："
for skill in "${SKILLS[@]}"; do
  echo "  /$skill"
done
