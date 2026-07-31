cask "loon@0.2.0.61" do
  version "0.2.0.61"
  sha256 "174e249548c4acddd865c12b578fde7cd40d3e0f7449c12578e6d03a0e351343"

  url "https://github.com/Loon0x00/Loon4Mac/releases/download/#{version.major_minor_patch}(#{version.split(".").last})/Loon-#{version.major_minor_patch}-beta-#{version.split(".").last}.dmg"
  name "Loon"
  desc "Network tool"
  homepage "https://github.com/Loon0x00/Loon4Mac"

  livecheck do
    skip "Pinned version for rollback"
  end

  auto_updates false
  conflicts_with cask: "loon"
  depends_on macos: :ventura

  app "Loon.app"

  zap trash: "/Users/Shared/com.loon.Loon"
end
