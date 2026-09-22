class Talk < Formula
  desc "Direct encrypted microphone and speaker conversations"
  homepage "https://github.com/k0ngk0ng/wire-talk"
  version "0.1.2"
  license "MIT"
  depends_on "k0ngk0ng/tap/wirectl"
  on_macos do
    on_arm do
      url "https://github.com/k0ngk0ng/wire-talk/releases/download/v0.1.2/wire-talk-0.1.2-darwin-arm64.tar.gz"
      sha256 "394a45c50f6c6d587420293dadf9a3660f82daa9d66745c8f2dccdfb2d3ea6e8"
    end
    on_intel do
      url "https://github.com/k0ngk0ng/wire-talk/releases/download/v0.1.2/wire-talk-0.1.2-darwin-amd64.tar.gz"
      sha256 "212c0221b9c05d767c210b51b7ab9790d6cd0448dc8e31526cbf8bb54e5f4f61"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/k0ngk0ng/wire-talk/releases/download/v0.1.2/wire-talk-0.1.2-linux-arm64.tar.gz"
      sha256 "6aad440450210c947bee6103db0432ab83e90511f98c3ac67435d5e8fb3250aa"
    end
    on_intel do
      url "https://github.com/k0ngk0ng/wire-talk/releases/download/v0.1.2/wire-talk-0.1.2-linux-amd64.tar.gz"
      sha256 "90bce37e46ef3b201aecab5d4215456ff0b127cdec7ffd102c1952e6a585e535"
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
