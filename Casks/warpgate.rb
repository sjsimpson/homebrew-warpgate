cask "warpgate" do
  version "0.1.0"
  sha256 "213b4f0f991d125676091d479e18a3378172e7b359240dfa9a7c5f1006e9834e"

  url "https://github.com/sjsimpson/warpgate/releases/download/v#{version}/warpgate_#{version}_aarch64.dmg"
  name "warpgate"
  desc "Taskwarrior reminders in the menu bar"
  homepage "https://github.com/sjsimpson/warpgate"

  depends_on arch: :arm64
  depends_on macos: :ventura

  app "warpgate.app"

  # Ad-hoc signed and not notarized, so macOS won't open it while it's quarantined.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/warpgate.app"],
        writable_paths: ["warpgate.app"],
        writable_base:  :appdir
  end

  uninstall quit: "dev.sjsimpson.warpgate"

  zap trash: "~/Library/LaunchAgents/warpgate.plist"
end
