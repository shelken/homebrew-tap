cask "tinycast" do
  version "0.17.0"
  sha256 "9f05c9ad42d7274415f7fdf9aea1f431404d917d6b9ac069f674ac7fdd732e43"

  url "https://github.com/shelken/tinycast/releases/download/v#{version}/Tinycast-#{version}.dmg"
  name "Tinycast"
  desc "Tiny, fully native launcher, hotkeys, and clipboard history"
  homepage "https://github.com/shelken/tinycast"

  livecheck do
    # 指 fork 自己的 release：上游先发而 fork 未同步时，fork 上没有对应 DMG，避免 bump 到 404
    url "https://github.com/shelken/tinycast/releases/latest"
    regex(%r{href=.*?/tag/v?(\d+(?:\.\d+)+)["' >]}i)
    strategy :page_match
  end

  auto_updates true
  conflicts_with cask: [
    "tinycast-sequoia",
    "tinycast-universal",
  ]
  depends_on arch: :arm64
  depends_on macos: :tahoe

  app "Tinycast.app"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Tinycast.app"]
  end

  uninstall quit: "com.tinycast.app"

  zap login_item: "Tinycast",
      trash:      [
        "~/Library/Application Support/com.tinycast.app",
        "~/Library/Caches/com.tinycast.app",
        "~/Library/Preferences/com.tinycast.app.plist",
        "~/Library/Saved Application State/com.tinycast.app.savedState",
      ]
end
