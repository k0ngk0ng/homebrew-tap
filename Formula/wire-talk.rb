class WireTalk < Formula
  desc "Direct encrypted microphone and speaker conversations"
  homepage "https://github.com/k0ngk0ng/wire-talk"
  version "0.2.3"
  license "MIT"
  depends_on "k0ngk0ng/tap/wirectl"
  on_macos do
    on_arm do
      url "https://github.com/k0ngk0ng/wire-talk/releases/download/v0.2.3/wire-talk-0.2.3-darwin-arm64.tar.gz"
      sha256 "4dc23352ec8cf5e316bb9bd491a5bbcc6061b267fffb9b2ff0f882a76e875b60"
    end
    on_intel do
      url "https://github.com/k0ngk0ng/wire-talk/releases/download/v0.2.3/wire-talk-0.2.3-darwin-amd64.tar.gz"
      sha256 "7ef73e91f717f2aa62ec2ad51738eff93edc1fade3de77e353ee526789743017"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/k0ngk0ng/wire-talk/releases/download/v0.2.3/wire-talk-0.2.3-linux-arm64.tar.gz"
      sha256 "b695142197eabd200da68d225b77f7c1e06905022fb9b4c0c50834d1676d9e0f"
    end
    on_intel do
      url "https://github.com/k0ngk0ng/wire-talk/releases/download/v0.2.3/wire-talk-0.2.3-linux-amd64.tar.gz"
      sha256 "cca430d099b3b992cf9d92ab69a54422a5293fa561bd606427db1dbf1a675dcc"
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
