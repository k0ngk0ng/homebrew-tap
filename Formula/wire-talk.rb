class WireTalk < Formula
  desc "Direct encrypted microphone and speaker conversations"
  homepage "https://github.com/k0ngk0ng/wire-talk"
  version "0.1.4"
  license "MIT"
  depends_on "k0ngk0ng/tap/wirectl"
  on_macos do
    on_arm do
      url "https://github.com/k0ngk0ng/wire-talk/releases/download/v0.1.4/wire-talk-0.1.4-darwin-arm64.tar.gz"
      sha256 "4a50dc47ca25d7aa9e64f2eba44d10f8aee8b71d8997a8937c202df84ed4fb2a"
    end
    on_intel do
      url "https://github.com/k0ngk0ng/wire-talk/releases/download/v0.1.4/wire-talk-0.1.4-darwin-amd64.tar.gz"
      sha256 "69f18d53ab76cbde4b7fe9463573d6065f97f6237c3c64190f89877f0355813a"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/k0ngk0ng/wire-talk/releases/download/v0.1.4/wire-talk-0.1.4-linux-arm64.tar.gz"
      sha256 "9f6b14a99a8d706036db07b383ad62f299f014b58861b9eab9a9f4711d276ddd"
    end
    on_intel do
      url "https://github.com/k0ngk0ng/wire-talk/releases/download/v0.1.4/wire-talk-0.1.4-linux-amd64.tar.gz"
      sha256 "f199cca67fcd001de68e53859783cd93746a097be80a897d44b44fd6e984f188"
    end
  end
  def install
    bin.install "bin/wirectl-talk"
    (bin/".wire-talk-package-manager").write "homebrew\n"
    doc.install "README.md", "THIRD_PARTY_NOTICES.md"
    doc.install "licenses"
  end
  test do
    assert_match version.to_s, shell_output("#{bin}/wirectl-talk version")
    system bin/"wirectl-talk", "init", "--state-dir", testpath/"state"
    assert_path_exists testpath/"state/config.json"
  end
end
