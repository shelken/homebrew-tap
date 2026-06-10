cask "typeswitch" do
  version "0.5.2"
  sha256 "f2e310d93a65a4d906f6026f8c7f02c693b5d9062e926c019f9f4171e6505397"

  url "https://github.com/ygsgdbd/TypeSwitch/releases/download/v#{version}/TypeSwitch-macOS-universal.zip"
  name "TypeSwitch"
  desc "快速切换输入法的工具"
  homepage "https://github.com/ygsgdbd/TypeSwitch"

  livecheck do
    url "https://github.com/ygsgdbd/TypeSwitch/releases/latest"
    regex(%r{href=.*?/tag/v?(\d+(?:\.\d+)+)["' >]}i)
    strategy :page_match
  end

  auto_updates false
  depends_on macos: :ventura

  app "TypeSwitch.app"

  zap trash: [
    "~/Library/Preferences/group.top.ygsgdbd.TypeSwitch.plist",
    "~/Library/Preferences/top.ygsgdbd.TypeSwitch.plist",
  ]

  caveats <<~EOS
    TypeSwitch is currently unsigned. You'll need to:
    1. Right-click the app and select "Open"
    2. Click "Open" in the dialog that appears
    3. Go to System Settings > Privacy & Security and approve the app
  EOS
end
