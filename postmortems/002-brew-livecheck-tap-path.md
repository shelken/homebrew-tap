# brew livecheck 依赖 tap 目录上下文

**日期**: 2026-01-13 
**影响**: `brew livecheck` 连续失败，并引出了无意义的替代尝试 
**发现人**: AI 自查

## 问题

把 cask 文件路径直接传给 `brew livecheck`，误以为它会像普通脚本一样独立工作。

## 现象

下面这类命令都会失败：

```bash
brew livecheck /path/to/Casks/loon.rb
brew livecheck --cask ./Casks/loon.rb
```

随后还尝试绕开 Homebrew 工作流，用 Ruby 代码模拟内部行为。

## 根因

错误假设是“只要给到文件路径，Homebrew 就能识别 cask”。实际约束是 cask 必须处在 Homebrew 认可的 tap 目录里，并通过 tap 名称调用。

## 修复

先把仓库放到 Homebrew 的 tap 路径，再用 tap 名称执行检查，例如：

```bash
ln -s ~/Code/MyRepo/homebrew-tap /opt/homebrew/Library/Taps/shelken/homebrew-tap
HOMEBREW_NO_AUTO_UPDATE=1 HOMEBREW_NO_INSTALL_FROM_API=1 brew livecheck shelken/tap/loon
```

## 预防

- 跑 `brew livecheck` 前，先确认当前仓库是否位于 tap 目录。
- 统一使用 tap 名称测试，不再对文件路径做无效试探。
- 工具工作流没搞清之前，不要先写替代实现。
