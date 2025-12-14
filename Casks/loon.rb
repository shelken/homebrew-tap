cask "loon" do
  version "0.1.34"
  sha256 "ba0cb2ce3390c02a0d787371526f2bc83373be797e65a69f7bbb8d8ac7d37f39"

  # 从版本号中提取 alpha 版本号
  alpha_version = version.split(".").last

  url "https://github.com/Loon0x00/Loon4Mac/releases/download/0.1(#{alpha_version})/Loon_alpha_#{alpha_version}.dmg"
  name "Loon"
  desc "Network tool"
  homepage "https://github.com/Loon0x00/Loon4Mac"

  livecheck do
    url "https://github.com/Loon0x00/Loon4Mac/releases/latest"
    regex(%r{href=.*?/tag/(\d+\.\d+)\((\d+)\)["' >]}i)
    strategy :page_match do |page, regex|
      match = page.match(regex)
      next if match.blank?

      "#{match[1]}.#{match[2]}"
    end
  end

  auto_updates false
  depends_on macos: ">= :monterey"

  app "Loon.app"

  zap trash: "/Users/Shared/com.loon.Loon"
end
