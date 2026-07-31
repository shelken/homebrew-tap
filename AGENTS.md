## 最高原则

- 生成文档/注释时使用中文描述
- 如果要hash值且是从github获取的url，优先使用 curl 调用 GitHub API 获取，示例：
  ```bash
  curl -s "https://api.github.com/repos/{owner}/{repo}/releases/latest" | jq '.assets[0].digest'
  # 返回格式: "sha256:xxxxxx"
  ```
- GitHub release assets 可能被作者替换成同 tag 不同文件（作者重新打包），导致 checksum 不匹配。更新 cask 时，必须重新下载实际文件并验证 checksum，不要沿用旧值

## 仓库概述

这是一个个人 Homebrew Tap 仓库，包含多个 macOS Cask 定义。Cask 定义文件位于 `Casks/` 目录下，使用 Ruby 编写。

## 常用命令

开发仓与 Homebrew tap 目录是两个独立 clone；`brew audit` / `livecheck` / `info` / `style` 只认 tap 内文件，且必须用 **tap token**，不能传 `Casks/*.rb` 路径（详见 `postmortems/002`）。

```bash
# 校验 cask 定义是否符合规范
brew audit --cask shelken/tap/<cask-name>

# 测试安装某个 cask
brew install --cask shelken/tap/<cask-name>

# 检查 cask 是否有新版本（livecheck）
HOMEBREW_NO_AUTO_UPDATE=1 HOMEBREW_NO_INSTALL_FROM_API=1 brew livecheck shelken/tap/<cask-name>

# 计算下载文件的 SHA256（使用 justfile 辅助命令）
just prefetch-url '<download-url>'
```

## Cask 定义结构

每个 cask 遵循以下结构：
- `version` 和 `sha256`：指定版本号和校验值
- `url`：下载地址，通常使用版本号插值
- `livecheck`：通过正则匹配 GitHub releases 页面检测新版本
- `app`：指定要安装的 .app 包名称
- 可选：`on_arm`/`on_intel` 块用于区分 ARM/Intel 架构的下载（参考 `fl-clash.rb`）
- 可选：`uninstall` 清理辅助程序，`zap` 清理用户数据，`caveats` 显示用户提示

## 版本更新流程

版本由 GitHub Actions 自动更新（`.github/workflows/autobump.yml`），每日运行 `Homebrew/actions/bump-packages`。手动更新步骤：
1. 更新 `version` 字符串
2. 下载新版本并计算 SHA256
3. 更新 `sha256`（架构特定的 cask 需更新两个值）
4. 使用 `brew audit` 和 `brew install` 测试

## Versioned 回退 cask

主 cask 始终跟最新；需要固定旧版回退时，新增独立 `Casks/<name>@<version>.rb`，与主 cask 共存。

- token / 文件名：`<name>@<完整版本>`（例：`loon@0.2.0.61`）
- 旧定义优先从 git 历史取，不要重写：`git log -S '<version>' -- Casks/<name>.rb` → `git show <commit>:Casks/<name>.rb`
- `livecheck do skip "Pinned version for rollback" end`（锁死版本，不跟新）
- `conflicts_with cask: "<主cask>"`（与主 cask 互斥安装同一 `.app`）
- **不要**写入 `autobump.yml`
