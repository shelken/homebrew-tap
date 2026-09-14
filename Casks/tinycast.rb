cask "tinycast" do
  version "0.10.23"
  sha256 "d1b8eb5bfdb56893e164d30be26e272e1bdfcf48c03d3163c5ba88110d277145"

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
    "tinycast-sequoia",
    "tinycast-universal",
  ]
  depends_on arch: :arm64
  depends_on macos: :tahoe

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
