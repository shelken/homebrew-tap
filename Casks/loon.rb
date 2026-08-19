cask "loon" do
  version "0.4.0.66"
  sha256 "1d0a5b0f050cea899bd344bba429d825091830c2480340a058e783c983fb9b87"

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
