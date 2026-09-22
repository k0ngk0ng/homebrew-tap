class WireTalk < Formula
  desc "Direct encrypted microphone and speaker conversations"
  homepage "https://github.com/k0ngk0ng/wire-talk"
  version "0.1.6"
  license "MIT"
  depends_on "k0ngk0ng/tap/wirectl"
  on_macos do
    on_arm do
      url "https://github.com/k0ngk0ng/wire-talk/releases/download/v0.1.6/wire-talk-0.1.6-darwin-arm64.tar.gz"
      sha256 "5584b9316569e1f93beca1b595ed75c45883fe12a09c9a8eb91a6929e1156f98"
    end
    on_intel do
      url "https://github.com/k0ngk0ng/wire-talk/releases/download/v0.1.6/wire-talk-0.1.6-darwin-amd64.tar.gz"
      sha256 "31dbd83e70901332d96acedb553e0e7a9c2ed80d336bb0a54f6fe94ad324ede9"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/k0ngk0ng/wire-talk/releases/download/v0.1.6/wire-talk-0.1.6-linux-arm64.tar.gz"
      sha256 "08d7864aa576326e7c5e18310d26fc7eecc31a009f92220661f0d19af3715002"
    end
    on_intel do
      url "https://github.com/k0ngk0ng/wire-talk/releases/download/v0.1.6/wire-talk-0.1.6-linux-amd64.tar.gz"
      sha256 "83faca71a584a738c0e73b057f498c9985ecbc59cd1ca509c8554dd14f023183"
    end
  end
  def install
    bin.install "bin/wirectl-talk"
    (bash_completion/"wirectl-talk").write Utils.safe_popen_read(bin/"wirectl-talk", "completion", "bash")
    (zsh_completion/"_wirectl-talk").write Utils.safe_popen_read(bin/"wirectl-talk", "completion", "zsh")
    (bin/".wire-talk-package-manager").write "homebrew\n"
    doc.install "README.md", "THIRD_PARTY_NOTICES.md"
    doc.install "licenses"
  end
  test do
    assert_match version.to_s, shell_output("#{bin}/wirectl-talk version")
    assert_path_exists bash_completion/"wirectl-talk"
    assert_path_exists zsh_completion/"_wirectl-talk"
    system bin/"wirectl-talk", "init", "--state-dir", testpath/"state"
    assert_path_exists testpath/"state/config.json"
  end
end
