cask "input-source-pro-beta" do
  version "0.1.0"
  sha256 "26c73ed6d99ab25a5d46666f7f66a5bb58a49dea72ab45cf70c2416cfd409bad"

  url "https://github.com/shelken/InputSourcePro/releases/download/v#{version}/Input-Source-Pro-Beta-v#{version}.dmg"
  name "Input Source Pro Beta"
  desc "自动切换输入法的工具 (Beta 版)，支持外部 JSON 配置"
  homepage "https://github.com/shelken/InputSourcePro"

  livecheck do
    url "https://github.com/shelken/InputSourcePro/releases/latest"
    regex(%r{href=.*?/tag/v?(\d+(?:\.\d+)+)["' >]}i)
    strategy :page_match
  end

  auto_updates false
  depends_on macos: ">= :ventura"

  app "Input Source Pro Beta.app"

  zap trash: [
    "~/.config/inputsourcepro",
    "~/Library/Application Support/space.ooooo.Input-Source-Pro.Beta",
    "~/Library/Preferences/space.ooooo.Input-Source-Pro.Beta.plist",
  ]

  caveats <<~EOS
    Input Source Pro Beta 使用自签名，首次运行需要：
    1. 右键点击应用，选择"打开"
    2. 在弹出的对话框中点击"打开"
    3. 或者运行: sudo xattr -r -d com.apple.quarantine /Applications/Input Source Pro Beta.app

    配置文件位置: ~/.config/inputsourcepro/config.json
  EOS
end
