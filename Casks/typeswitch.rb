cask "typeswitch" do
  version "0.3.5"
  sha256 "3f27abf2dd511a3c7184a9cbe354452931416980dfada792ad96727574690679"

  url "https://github.com/ygsgdbd/TypeSwitch/releases/download/v#{version}/TypeSwitch.dmg"
  name "TypeSwitch"
  desc "A tool to quickly switch between different input sources on macOS"
  homepage "https://github.com/ygsgdbd/TypeSwitch"

  depends_on macos: ">= :ventura"

  app "TypeSwitch.app"

zap trash: [
    "~/Library/Application Support/TypeSwitch",
    "~/Library/Preferences/top.ygsgdbd.TypeSwitch.plist",
    "~/Library/Caches/top.ygsgdbd.TypeSwitch"
  ]
end
