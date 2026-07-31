# brew 命令依赖 tap 目录与 tap token

**日期**: 2026-01-13  
**影响**: `brew livecheck` / `audit` / `info` / `style` 连续失败，并引出无意义的替代尝试  
**发现人**: AI 自查

## 问题

把 cask 文件路径直接传给 `brew livecheck` / `audit` / `info`，误以为它会像普通脚本一样独立工作。

## 现象

下面这类命令都会失败：

```bash
brew livecheck /path/to/Casks/loon.rb
brew livecheck --cask ./Casks/loon.rb
brew audit --cask Casks/loon.rb
brew info --cask ./Casks/loon.rb
```

`brew audit [path …]` 甚至会直接报 path 参数已禁用。开发仓里的新文件若尚未进入 tap clone，`brew info shelken/tap/<name>` 也会找不到 cask。

随后还尝试绕开 Homebrew 工作流，用 Ruby 代码模拟内部行为。

## 根因

错误假设是「只要给到文件路径，Homebrew 就能识别 cask」。实际约束：

1. cask 必须处在 Homebrew 认可的 tap 目录里，并通过 **tap token** 调用。
2. 开发仓（如 `Code/active/homebrew-tap`）与 tap 目录（`$(brew --repository)/Library/Taps/shelken/homebrew-tap`）常常是两个独立 clone；只改开发仓时，brew 看不到新文件。

## 修复

先保证文件在 tap 路径可见（symlink 开发仓、push 后 pull tap，或临时拷贝验证），再用 tap 名称执行：

```bash
# 可选：开发仓与 tap 合一
ln -sfn <开发仓路径> /opt/homebrew/Library/Taps/shelken/homebrew-tap

HOMEBREW_NO_AUTO_UPDATE=1 HOMEBREW_NO_INSTALL_FROM_API=1 brew livecheck shelken/tap/loon
brew audit --cask shelken/tap/loon
brew style --cask shelken/tap/loon
brew info --cask shelken/tap/loon
```

## 预防

- 跑任何 `brew` cask 子命令前，先确认目标文件已在 tap 目录。
- 统一使用 tap token（`shelken/tap/<name>`），不再对文件路径做无效试探。
- 工具工作流没搞清之前，不要先写替代实现。
