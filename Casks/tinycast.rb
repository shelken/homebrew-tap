cask "tinycast" do
  version "0.10.5"
  sha256 "76ccae503bb3f6e70c4d75cf78a75c8659e41befe534ebc4e3d228e1c6ebf265"

  url "https://github.com/shelken/tinycast/releases/download/v#{version}/Tinycast-#{version}.dmg"
  name "Tinycast"
  desc "Tiny, fully native launcher, hotkeys, and clipboard history"
  homepage "https://github.com/shelken/tinycast"

  livecheck do
    url "https://github.com/abue-ammar/tinycast/releases/latest"
    regex(%r{href=.*?/tag/v?(\d+(?:\.\d+)+)["' >]}i)
    strategy :page_match
  end

  auto_updates true
  conflicts_with cask: [
    "tinycast-universal",
    "tinycast-sequoia",
  ]
  depends_on macos: :tahoe
  depends_on arch: :arm64

  app "Tinycast.app"

  preflight_steps do
    if_path_exists "Tinycast.app", base: :appdir do
      touch ".upgrade"
    end
  end

  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Tinycast.app"]

    unless_path_exists ".upgrade" do
      run "/usr/bin/open", args: ["-g", "{{appdir}}/Tinycast.app"]
    end

    remove ".upgrade"
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
