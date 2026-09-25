class WireTalk < Formula
  desc "Direct encrypted microphone and speaker conversations"
  homepage "https://github.com/k0ngk0ng/wire-talk"
  version "0.2.0"
  license "MIT"
  depends_on "k0ngk0ng/tap/wirectl"
  on_macos do
    on_arm do
      url "https://github.com/k0ngk0ng/wire-talk/releases/download/v0.2.0/wire-talk-0.2.0-darwin-arm64.tar.gz"
      sha256 "ab2ccafaaec845f3168b4dfb4c9f306238509f1bf24710e7c96a206f7fb96a8b"
    end
    on_intel do
      url "https://github.com/k0ngk0ng/wire-talk/releases/download/v0.2.0/wire-talk-0.2.0-darwin-amd64.tar.gz"
      sha256 "a1a9fca1ecb6afe557fb93422c4280516d9ea72b06d61850223cc248a6677172"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/k0ngk0ng/wire-talk/releases/download/v0.2.0/wire-talk-0.2.0-linux-arm64.tar.gz"
      sha256 "a6cfa78f55a9605fe600e046772b754c6dddb56be9cfcb516944b836bae514f7"
    end
    on_intel do
      url "https://github.com/k0ngk0ng/wire-talk/releases/download/v0.2.0/wire-talk-0.2.0-linux-amd64.tar.gz"
      sha256 "402b7f570a63f85e07590017f2e57e1d77a6c4674e426939950826d8cd03f288"
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
