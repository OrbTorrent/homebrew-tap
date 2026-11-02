cask "orbtorrent" do
  version "1.0"
  sha256 "b9af3fdf483542f5e26e63d8283a80d4411b77e7ec10c510e53fe26afade98a1"

  url "https://github.com/OrbTorrent/OrbTorrent/releases/download/v#{version}/OrbTorrent-1.0-universal.dmg"
  name "OrbTorrent"
  desc "Torrent client for the menu bar, built on qBittorrent's engine"
  homepage "https://orbtorrent.com/"

  # The update feed OrbTorrent updates itself from. Its disk images are
  # downloaded from each release, whose tag is the version.
  livecheck do
    url "https://updates.orbtorrent.com/appcast.xml"
    strategy :sparkle do |items|
      items.filter_map { |item| item.url[%r{/download/v?([^/]+)/}i, 1] }
    end
  end

  auto_updates true
  depends_on macos: :tahoe

  app "OrbTorrent.app"

  uninstall quit: "com.orbtorrent.mac"

  zap trash: [
    "~/Library/Application Scripts/com.orbtorrent.mac.extension-host",
    "~/Library/Application Support/OrbTorrent",
    "~/Library/Caches/com.orbtorrent.mac",
    "~/Library/Containers/com.orbtorrent.mac.extension-host",
    "~/Library/HTTPStorages/com.orbtorrent.mac",
    "~/Library/Preferences/com.orbtorrent.mac.plist",
  ]
end
