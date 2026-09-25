class WireTalk < Formula
  desc "Direct encrypted microphone and speaker conversations"
  homepage "https://github.com/k0ngk0ng/wire-talk"
  version "0.2.2"
  license "MIT"
  depends_on "k0ngk0ng/tap/wirectl"
  on_macos do
    on_arm do
      url "https://github.com/k0ngk0ng/wire-talk/releases/download/v0.2.2/wire-talk-0.2.2-darwin-arm64.tar.gz"
      sha256 "9b6f861bbfa48b014214a56ecaa09a87d7721825ba13cc8ae23891d1232a36f8"
    end
    on_intel do
      url "https://github.com/k0ngk0ng/wire-talk/releases/download/v0.2.2/wire-talk-0.2.2-darwin-amd64.tar.gz"
      sha256 "03f5f522a5ddfafc6eb9bd640b7249d6d1f3894f2f18070926eaf8617df97ae9"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/k0ngk0ng/wire-talk/releases/download/v0.2.2/wire-talk-0.2.2-linux-arm64.tar.gz"
      sha256 "d16a1317601afe83e195b1040486247cf341afa69bee1708373056d222a44839"
    end
    on_intel do
      url "https://github.com/k0ngk0ng/wire-talk/releases/download/v0.2.2/wire-talk-0.2.2-linux-amd64.tar.gz"
      sha256 "035102865b1d77a7435e791d7690f374075a950df73b723154911222f60fbe06"
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
