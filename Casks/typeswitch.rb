cask "typeswitch" do
  version "0.4"
  sha256 "51a396a75708b745411c5d008b02bed793631f1b2f4ef5aab6fe1407b9eff8bb"

  url "https://github.com/ygsgdbd/TypeSwitch/releases/download/v#{version}/TypeSwitch.dmg"
  name "TypeSwitch"
  desc "快速切换输入法的工具"
  homepage "https://github.com/ygsgdbd/TypeSwitch"

  livecheck do
    url "https://api.github.com/repos/ygsgdbd/TypeSwitch/releases/latest"
    strategy :json do |json|
      json["tag_name"]&.gsub(/^v/, "")
    end
  end

  auto_updates false
  depends_on macos: ">= :ventura"

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
