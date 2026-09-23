class WireTalk < Formula
  desc "Direct encrypted microphone and speaker conversations"
  homepage "https://github.com/k0ngk0ng/wire-talk"
  version "0.1.11"
  license "MIT"
  depends_on "k0ngk0ng/tap/wirectl"
  on_macos do
    on_arm do
      url "https://github.com/k0ngk0ng/wire-talk/releases/download/v0.1.11/wire-talk-0.1.11-darwin-arm64.tar.gz"
      sha256 "16c6e3daac9b0d89e143abd06afeb42db7f186dc3b828a48147d43cad917fa33"
    end
    on_intel do
      url "https://github.com/k0ngk0ng/wire-talk/releases/download/v0.1.11/wire-talk-0.1.11-darwin-amd64.tar.gz"
      sha256 "4c3a81e12c194a60c061dd47f4f992b22602cbf04b48731df38ddf839b4b2cca"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/k0ngk0ng/wire-talk/releases/download/v0.1.11/wire-talk-0.1.11-linux-arm64.tar.gz"
      sha256 "aebf1a96f002a9dd27a4bcd58654d009884bc686e38c4bdd43d4969941b4aae9"
    end
    on_intel do
      url "https://github.com/k0ngk0ng/wire-talk/releases/download/v0.1.11/wire-talk-0.1.11-linux-amd64.tar.gz"
      sha256 "546b5e49b7e610ca9f2c0c9cf1ca3fa0007bd95b8b9fee5a590c12d69fc16f77"
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
