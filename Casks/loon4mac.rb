cask "loon" do
  version "0.1(29)"
  sha256 "31eee8a2a12059c0ddc8319b51ccd1c2ed668d6b09c662fb3199bb5cb809ac54"

  # 从版本号中提取 alpha 版本号
  alpha_version = version[/\((\d+)\)/, 1]

  url "https://github.com/Loon0x00/Loon4Mac/releases/download/#{version}/Loon_alpha_#{alpha_version}.dmg"
  name "Loon"
  desc "Network tool"
  homepage "https://github.com/Loon0x00/Loon4Mac"

  livecheck do
    url "https://api.github.com/repos/Loon0x00/Loon4Mac/releases/latest"
    strategy :json do |json|
      json["tag_name"]
    end
  end

  auto_updates false

  # depends_on macos: ">= :ventura"

  app "Loon.app"

  zap trash: "/Users/Shared/com.loon.Loon"
end
