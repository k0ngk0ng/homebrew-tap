class WireTalk < Formula
  desc "Direct encrypted microphone and speaker conversations"
  homepage "https://github.com/k0ngk0ng/wire-talk"
  version "0.1.5"
  license "MIT"
  depends_on "k0ngk0ng/tap/wirectl"
  on_macos do
    on_arm do
      url "https://github.com/k0ngk0ng/wire-talk/releases/download/v0.1.5/wire-talk-0.1.5-darwin-arm64.tar.gz"
      sha256 "0e2d27b87f903fc7672d6654d50e6080d34adf4880851d98cc8fa190e94b4e6c"
    end
    on_intel do
      url "https://github.com/k0ngk0ng/wire-talk/releases/download/v0.1.5/wire-talk-0.1.5-darwin-amd64.tar.gz"
      sha256 "2b91d9a1c8ff681086eed9d1307d09e14973a91bdf69713e91d1b3ddbbc73779"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/k0ngk0ng/wire-talk/releases/download/v0.1.5/wire-talk-0.1.5-linux-arm64.tar.gz"
      sha256 "c2f5ac948fb839271f18fae3c314cc5c7ec6b16c402116bca84f4262541e6431"
    end
    on_intel do
      url "https://github.com/k0ngk0ng/wire-talk/releases/download/v0.1.5/wire-talk-0.1.5-linux-amd64.tar.gz"
      sha256 "f5ad76b82e8c5380394349e9108c9358013f865dad256efcfda8d377b4052ac2"
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
