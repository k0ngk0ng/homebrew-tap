class WireTalk < Formula
  desc "Direct encrypted microphone and speaker conversations"
  homepage "https://github.com/k0ngk0ng/wire-talk"
  version "0.1.9"
  license "MIT"
  depends_on "k0ngk0ng/tap/wirectl"
  on_macos do
    on_arm do
      url "https://github.com/k0ngk0ng/wire-talk/releases/download/v0.1.9/wire-talk-0.1.9-darwin-arm64.tar.gz"
      sha256 "e5ff8539d0ef39b7523447203d852116eda19cb9ce14550a3f94b94cfefa7f7c"
    end
    on_intel do
      url "https://github.com/k0ngk0ng/wire-talk/releases/download/v0.1.9/wire-talk-0.1.9-darwin-amd64.tar.gz"
      sha256 "0d06315100a560f826553b316986c1186609a2fd4235e43aecdfc64253884431"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/k0ngk0ng/wire-talk/releases/download/v0.1.9/wire-talk-0.1.9-linux-arm64.tar.gz"
      sha256 "8db5de0187fbe291dd8232754b41e5949ce9d950cdeb48ab60bac444e865223d"
    end
    on_intel do
      url "https://github.com/k0ngk0ng/wire-talk/releases/download/v0.1.9/wire-talk-0.1.9-linux-amd64.tar.gz"
      sha256 "ee187f239fc7641e73dea07534e054711e75f9ea59fa5dde4157064a9450834d"
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
