cask "loon" do
  version "0.5.0.1011"
  sha256 "5dba952ca182099c17cd8230f97ba7d4894453d7f279b588577113b37b0740b1"

  url "https://github.com/Loon0x00/Loon4Mac/releases/download/#{version.major_minor_patch}(#{version.split(".").last})/Loon-#{version.major_minor_patch}-beta-#{version.split(".").last}.dmg"
  name "Loon"
  desc "Network tool"
  homepage "https://github.com/Loon0x00/Loon4Mac"

  livecheck do
    url "https://github.com/Loon0x00/Loon4Mac/releases/latest"
    regex(%r{href=.*?/tag/(\d+\.\d+\.\d+)\((\d+)\)["' >]}i)
    strategy :page_match do |page, regex|
      match = page.match(regex)
      next if match.blank?

      "#{match[1]}.#{match[2]}"
    end
  end

  auto_updates false
  depends_on macos: :ventura

  app "Loon.app"

  zap trash: "/Users/Shared/com.loon.Loon"
end
