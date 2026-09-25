class WireTalk < Formula
  desc "Direct encrypted microphone and speaker conversations"
  homepage "https://github.com/k0ngk0ng/wire-talk"
  version "0.2.5"
  license "MIT"
  depends_on "k0ngk0ng/tap/wirectl"
  on_macos do
    on_arm do
      url "https://github.com/k0ngk0ng/wire-talk/releases/download/v0.2.5/wire-talk-0.2.5-darwin-arm64.tar.gz"
      sha256 "21cc6b8cb4d3de5b48b7769ec9fcb655b8a6d5872d3fdffb5366bf4ded8a1e72"
    end
    on_intel do
      url "https://github.com/k0ngk0ng/wire-talk/releases/download/v0.2.5/wire-talk-0.2.5-darwin-amd64.tar.gz"
      sha256 "0ddb09031c0c2c9bd3e6a33c5da7167f8910b545aba2f965298d3dd55c93b83d"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/k0ngk0ng/wire-talk/releases/download/v0.2.5/wire-talk-0.2.5-linux-arm64.tar.gz"
      sha256 "2c008d105ca2e7b23a1f40d156ae544fc8b7a35161097bccddb0547ae32dd90c"
    end
    on_intel do
      url "https://github.com/k0ngk0ng/wire-talk/releases/download/v0.2.5/wire-talk-0.2.5-linux-amd64.tar.gz"
      sha256 "6009d2ae5c7c129a816bc071ad0e9808b1653279b811e19c6e6801c28ec8abf8"
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
