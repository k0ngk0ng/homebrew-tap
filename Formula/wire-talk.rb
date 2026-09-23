class WireTalk < Formula
  desc "Direct encrypted microphone and speaker conversations"
  homepage "https://github.com/k0ngk0ng/wire-talk"
  version "0.1.10"
  license "MIT"
  depends_on "k0ngk0ng/tap/wirectl"
  on_macos do
    on_arm do
      url "https://github.com/k0ngk0ng/wire-talk/releases/download/v0.1.10/wire-talk-0.1.10-darwin-arm64.tar.gz"
      sha256 "d805bbca9805403cc2c4307b85c6505e03236e4959e9a629e22503159b5967b9"
    end
    on_intel do
      url "https://github.com/k0ngk0ng/wire-talk/releases/download/v0.1.10/wire-talk-0.1.10-darwin-amd64.tar.gz"
      sha256 "d16b3e24de8059da4da989e880407496453a6a0e269bc68281536b60020dc483"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/k0ngk0ng/wire-talk/releases/download/v0.1.10/wire-talk-0.1.10-linux-arm64.tar.gz"
      sha256 "2648855b78c301518e44158be4a47512f98d93914ea9b68772ac1d1dae41beb4"
    end
    on_intel do
      url "https://github.com/k0ngk0ng/wire-talk/releases/download/v0.1.10/wire-talk-0.1.10-linux-amd64.tar.gz"
      sha256 "b13a7b7dbe8312063b9afbe3156ef13e9f0be4dc47f8bed07e55349085bd41fd"
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
