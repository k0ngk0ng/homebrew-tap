class WireTalk < Formula
  desc "Direct encrypted microphone and speaker conversations"
  homepage "https://github.com/k0ngk0ng/wire-talk"
  version "0.1.8"
  license "MIT"
  depends_on "k0ngk0ng/tap/wirectl"
  on_macos do
    on_arm do
      url "https://github.com/k0ngk0ng/wire-talk/releases/download/v0.1.8/wire-talk-0.1.8-darwin-arm64.tar.gz"
      sha256 "f647bdc4e6fab506ec0e9b0f3214c8a0343803874ef241cc08259b355f9917bf"
    end
    on_intel do
      url "https://github.com/k0ngk0ng/wire-talk/releases/download/v0.1.8/wire-talk-0.1.8-darwin-amd64.tar.gz"
      sha256 "5a91647e7ac962a2970e9c5fec9f337f4d2c9af0d00b79922691a8d52dcc2622"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/k0ngk0ng/wire-talk/releases/download/v0.1.8/wire-talk-0.1.8-linux-arm64.tar.gz"
      sha256 "5be55a01bc558e6c4f119b98f5ebb8309c0a9a6e0eea5508ba5e340d1e649a9c"
    end
    on_intel do
      url "https://github.com/k0ngk0ng/wire-talk/releases/download/v0.1.8/wire-talk-0.1.8-linux-amd64.tar.gz"
      sha256 "34569003cb3909dc89716fc8b6fadc3b7e291fea36571c88fda6371712e7319d"
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
