class WireTalk < Formula
  desc "Direct encrypted microphone and speaker conversations"
  homepage "https://github.com/k0ngk0ng/wire-talk"
  version "0.1.12"
  license "MIT"
  depends_on "k0ngk0ng/tap/wirectl"
  on_macos do
    on_arm do
      url "https://github.com/k0ngk0ng/wire-talk/releases/download/v0.1.12/wire-talk-0.1.12-darwin-arm64.tar.gz"
      sha256 "402728fdf593974251f8483d1cfd8fef14f7209c11c34d7baea9f36f5e7c2461"
    end
    on_intel do
      url "https://github.com/k0ngk0ng/wire-talk/releases/download/v0.1.12/wire-talk-0.1.12-darwin-amd64.tar.gz"
      sha256 "60f3989c31a13118f21a4f96d1ec3b70979dbc4485377944d1c839467069e0c0"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/k0ngk0ng/wire-talk/releases/download/v0.1.12/wire-talk-0.1.12-linux-arm64.tar.gz"
      sha256 "619901feffa206ffc495bcd7ef1c62418136f13406931aaa1424ccb4cada8f3e"
    end
    on_intel do
      url "https://github.com/k0ngk0ng/wire-talk/releases/download/v0.1.12/wire-talk-0.1.12-linux-amd64.tar.gz"
      sha256 "aa951f2b1708ec9355d2e0fcd14874774fe9b16638d7d9cedfa86d758caa8e2e"
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
